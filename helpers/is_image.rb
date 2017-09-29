$image_ext = ['png', 'jpg', 'jpeg', 'gif']

def is_image(filename)
    name_parts = filename.split '.'
    $image_ext.include? name_parts[-1]
end

