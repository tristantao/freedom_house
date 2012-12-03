require 'svm'
require 'boolean_to_i'

class Admin::ClassifierController < ApplicationController

  def index
    # Labels for each document in the training set
    ##   1 = contains_hatespeech, 0 = Not-contains_hatespeech
    @labels = []
    @documents = []
    @test_labels = []
    @test_documents = []
    @total = Article.count
    Article.all.each do |article|
      if Random.rand <= 2.0/3.0
        # Training set:
        @labels << article.contains_hatespeech.to_i
        @documents << %[#{article.text}]
      else
        # Testing set:
        @test_labels << article.contains_hatespeech.to_i
        @test_documents << %[#{article.text}]
      end
    end

    # Build a global dictionary of all possible words
    dictionary = (@documents+@test_documents).flatten.uniq
    #dictionary = "Global dictionary: \n #{dictionary.inspect}\n\n"

    # Build binary feature vectors for each document
    #  - If a word is present in document, it is marked as '1', otherwise '0'
    #  - Each word has a unique ID as defined by 'dictionary'
    feature_vectors = @documents.map { |doc| dictionary.map{|x| doc.include?(x) ? 1 : 0} }
    test_vectors = @test_documents.map { |doc| dictionary.map{|x| doc.include?(x) ? 1 : 0} }

    @first_training_vector = "First training vector: #{feature_vectors.first.inspect}\n"
    @first_test_vector = "First test vector: #{test_vectors.first.inspect}\n"

    # Define kernel parameters -- we'll stick with the defaults
    pa = Parameter.new
    pa.C = 100
    pa.svm_type = NU_SVC
    pa.degree = 1
    pa.coef0 = 0
    pa.eps= 0.001
    pa.nu = 0.2

    sp = Problem.new(@labels, feature_vectors)

    # Original code from vIgita
    #sp = Problem.new
    #labels.each_index { |i| sp.addExample(labels[i], feature_vectors[i]) }

    # We're not sure which Kernel will perform best, so let's give each a try
    kernels = [ LINEAR, POLY, RBF, SIGMOID ]
    kernel_names = [ 'Linear', 'Polynomial', 'Radial basis function', 'Sigmoid' ]
    @kernel_errors_training = []
    @kernel_errors_testing = []
    @kernel_predictions_training = []
    @kernel_predictions_testing = []
    kernels.each_index { |j|
      # Iterate and over each kernel type
      pa.kernel_type = kernels[j]
      m = Model.new(sp, pa)
      errors = 0

      # Test kernel performance on the training set
      @labels.each_index { |i|
        pred, probs = m.predict_probability(feature_vectors[i])
        @kernel_predictions_training << "Prediction: #{pred}, True label: #{@labels[i]}, Kernel: #{kernel_names[j]}"
        errors += 1 if @labels[i] != pred
      }
      @kernel_errors_training << "Kernel #{kernel_names[j]} made #{errors} errors on the training set"

      # Test kernel performance on the test set
      errors = 0
      @test_labels.each_index { |i|
        pred, probs = m.predict_probability(test_vectors[i])
        @kernel_predictions_testing << "Prediction: #{pred}, True label: #{@test_labels[i]}"
        errors += 1 if @test_labels[i] != pred
      }

      @kernel_errors_testing << "Kernel #{kernel_names[j]} made #{errors} errors on the test set"
    }

  end
end
