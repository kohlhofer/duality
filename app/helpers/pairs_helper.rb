module PairsHelper

  TEXT_SIZE_CLASSES = ['short', 'medium', 'long']

  def text_size_class_for_pair_item(item)
    TEXT_SIZE_CLASSES[item.length / 10]
  end

end
