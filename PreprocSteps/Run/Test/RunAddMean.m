classdef RunAddMean < RunPreproc
    
    methods
        function obj = RunAddMean(base_dir, step_no, name, description, prefix, required_params, params_output)
            if nargin == 2
                name = 'AddMean';
                description = 'add mean from template image';
                prefix = 'am';
                required_params = {'mean_image'};
                params_output = {};
            end
            
            % Call RunPreproc constructor
            obj@RunPreproc(base_dir, step_no, name, description, prefix, required_params, params_output);
        end
        
        % main function for Add mean of template to each image
        
        function output_image = run(obj, input_image, params)
            
            % read in image
            vol = niftiread(input_image);
            
            % read in mean image
            mean_image = niftiread(params.mean_image);
            mean_image_4D = repmat(mean_image, 1, 1, 1, size(vol, 4));
            
            
            % generate new filename
            [~, image_name, ~] = fileparts(input_image);
            output_image =  [obj.prefix, '_', image_name, '.nii'];
            
            % write out file
            niftiwrite(vol + mean_image_4D, fullfile(obj.step_dir,output_image));
        end
        
        
    end
    
end