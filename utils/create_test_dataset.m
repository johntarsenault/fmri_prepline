function vols = create_test_dataset(run_no, image_dimension, name_root, output_dir)

if nargin == 2
    write_nii = false;
elseif nargin == 4
    write_nii = true;
end

% write volumes
vols = cell(run_no, 1);
for i = 1:run_no
    rng(i);
    vols{i} = rand(image_dimension);
end


if write_nii
    % make dir if does not exist
    if ~exist(output_dir)
        mkdir(output_dir)
    end
    
    %write test nifti filesrand(image_dimension)
    for i = 1:run_no
        
        filename = fullfile(output_dir, [name_root, sprintf('%02d', i), '.nii']);
        niftiwrite(vols{i}, filename);
    end
end
