classifiers = [{:problem => "nigeria", :on_off => true}]

classifiers.each do |classifier|
  c = Classifier.new(classifier)
  c.retrain
  c.save
end
