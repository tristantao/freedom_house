module ChiSquared

  def chi_squared(labels, doc_array, words, top_k = 1000)
    total_pos = 0
    labels.each do |hateful|
      total_pos += hateful
    end
    total_pos = total_pos.to_f
    total_neg = (labels.length - total_pos).to_f
    total = labels.length.to_f

    feature_vector = {}
    words.each do |word|
      tp = 0.0
      fp = 0.0
      tn = 0.0
      fn = 0.0
      doc_array.each_with_index do |document, index|
        if labels[index]
          if document.include?(word)
            tp+=1
          else
            fn+=1
          end
        else
          if document.include?(word)
            fp+=1
          else
            tn+=1
          end
        end
      end
      chi_sq = g_function(tp, (tp+fp)*total_pos/total) + g_function(fn, (fn+tn)*total_pos/total) +  g_function(fp, (tp+fp)*total_neg/total) + g_function(tn, (fn+tn)*total_neg/total)
      feature_vector[word] = chi_sq
    end
    sorted_feature = feature_vector.sort{|feature1, feature2| feature2[1] <=> feature1[1]}
    sorted_feature.map{|key, val| key}.take(top_k)
  end

  private
  def g_function(observed, expected)
    f_observed = observed.to_f
    f_expected = expected.to_f
    res = (f_observed - f_expected)**2 / f_expected
    if res.nan? or res.infinite? or res.nil?
      res = 0.0
    end
    return res
  end
end
