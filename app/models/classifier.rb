require 'svm'
require 'boolean_to_i'
require 'chi_squared'
require 'svm'

class Classifier < ActiveRecord::Base
include ::ChiSquared

  has_many :sources
  attr_accessible :problem, :accuracy, :top_features, :on_off
  serialize :top_features, Array
  
  def classify(articles, source)
    total_article = articles.size
    increment = 25.0 / total_article
    completed = 0.0
    m = Model.new(self.id.to_s+".model")

    articles.each do |article|
      doc = article.text
      feature_vectors = self.top_features.map{|x| doc.include?(x) ? 1 : 0}
      pred, probs = m.predict_probability(feature_vectors)
      article.contains_hatespeech = pred.to_i
      article.save!
      if !source.nil?
        completed += increment
        source.progress_classify = completed.to_s + "%"
        source.save
      end
    end
  end

  def retrain
    # Labels for each document in the training set
    ##   1 = contains_hatespeech, 0 = Not-contains_hatespeech
    @labels, @documents, @test_labels, @test_documents = [], [], [], []
    @total = Article.count
    k = 3.0
    for i in 0..k-1
      @labels[i] = []
      @documents[i] = []
    end

    Article.all.each do |article|
      bucket_num = (Random.rand * k).floor
      @labels[bucket_num] << article.contains_hatespeech.to_i
      @documents[bucket_num] << %[#{article.text}]
    end

    # Build a hash whose keys are words and values are number of occurrences in all documents
    @doc_count = {}
    docs = @documents.flatten
    docs.each do |words|
      subbed = words.gsub(/[^\w\s]/, '').downcase!
      if subbed.nil?
        subbed = ""
      end
      subbed.scan(/\w+/).each do |word|
        if @doc_count.include?(word)
          @doc_count[word] += 1
        else
          @doc_count[word] = 1
        end
      end
    end

    # Document Frequency minimum Feature Selection
    # --> Eliminate words that do not show up more than once
    @doc_count.each do |k, v|
      @doc_count.delete(k) if v < 2
    end

    # Define kernel parameters -- we'll stick with the defaults
    pa = Parameter.new
    pa.C = 100
    pa.svm_type = NU_SVC
    pa.degree = 1
    pa.coef0 = 0
    pa.eps= 0.001
    pa.nu = 0.4

    # We're not sure which Kernel will perform best, so let's give each a try
    kernels = [LINEAR, RBF]
    @accuracy = Array.new(kernels.length)
    kernel_names = [ 'Linear', 'Radial basis function']
    kernels.each_index do |kernel|
      # Iterate and over each kernel type
      pa.kernel_type = kernels[kernel]

      # Cross validation over k-folds
      for c_vd in 0..k-1
        @test_labels = @labels[c_vd]
        @test_documents = @documents[c_vd]
        @labels[c_vd] = []
        @documents[c_vd] = []
        #debugger
        # Chi-Squared Feature Selection
        top_features = chi_squared(@labels.flatten, @documents.flatten, @doc_count.keys, 1000)

        # --------------------------------------------------------
        # Method #1:
        # Only keep the top features within doc_count
        # Store the log-odds calculated value
=begin
           temp = @doc_count
           @doc_count = {}
           top_features.each do |feature|
            @doc_count[feature] = temp[feature]
          end
=end
        # ---------------------------------------------------------
        # Method #2:
        # Binary feature vectors. 1= word is included, 0= word is not included
        feature_vectors = @documents.flatten.map { |doc| top_features.map{|x| doc.include?(x) ? 1 : 0} }
        test_vectors = @test_documents.map { |doc| top_features.map{|x| doc.include?(x) ? 1 : 0} }
        sp = Problem.new(@labels.flatten, feature_vectors)

        m = Model.new(sp, pa)

        correct = 0

        # Test kernel performance on the test set
        @test_labels.each_index { |i|
          pred, probs = m.predict_probability(test_vectors[i])
          correct += 1 if @test_labels[i] == pred
        }
        new_accuracy = correct.to_f/@test_labels.length.to_f
        if @accuracy[kernel].nil?
          @accuracy[kernel] = new_accuracy
        else
          @accuracy[kernel] = (@accuracy[kernel]*(c_vd) + new_accuracy)/(c_vd+1)
        end
        @labels[c_vd] = @test_labels
        @documents[c_vd] = @test_documents
      end

      feature_vectors = @documents.flatten.map { |doc| top_features.map{|x| doc.include?(x) ? 1 : 0} }
      sp = Problem.new(@labels.flatten, feature_vectors)
      m = Model.new(sp, pa)
      m.save(self.id.to_s+".model")
      if not @accuracy[0].nan?
        self.accuracy = @accuracy[0]
      end
      self.top_features = top_features
      self.save!
    end
  end
end
