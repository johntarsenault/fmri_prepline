function input = get_input_images(input_dir, image_ext)

if nargin == 1
    image_ext = '.nii';
end

input.dir = input_dir;
images = dir(fullfile(input_dir,['*', image_ext]));
input.image_name = {images.name};