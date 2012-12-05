Given /the classifier is instantiated$/ do
  c = Classifier.create(:problem => "Nigeria" , :top_features => ["attack", "kill"], :on_off => 1)
end

Given /^Jobs are being dispatched$/ do
  Delayed::Worker.new.work_off
end
