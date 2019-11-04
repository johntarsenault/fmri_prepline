classdef RunAdd2 < RunPreproc
    
    methods
        function obj = RunAdd2(base_dir, step_no, name, description, prefix, required_params, params_output)
            if nargin == 2
                name = 'Add2';
                description = 'add number 2';
                prefix = 'a2';
                required_params = {};
                params_output = {};
            end
            
            % Call RunPreproc constructor
            obj@RunPreproc(base_dir, step_no, name, description, prefix, required_params, params_output);
        end
        
        % main function for Add 2 step
        % adds 2 to a every voxel in nifti images
        function output_image = run(obj, input_image, params)
            
            % read in image and add 2
            vol = niftiread(input_image);
            vol = vol + 2;
            
            % generate new filename
            [~, input_image_name, ~] = fileparts(input_image);
            output_image = [obj.prefix, '_', input_image_name, '.nii'];
            
            % write out file
            niftiwrite(vol, fullfile(obj.step_dir, output_image));
        end
        
        
    end
    
end