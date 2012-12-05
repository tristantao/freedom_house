classifiers = [{:problem => "nigeria", :on_off => 1}]

classifiers.each do |classifier|
  c = Classifier.new(classifier)
  c.retrain
  c.save
end
