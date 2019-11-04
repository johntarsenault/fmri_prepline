classdef MakeMean < MakePreproc
    
    methods
        function obj = MakeMean(base_dir, step_no, name, description, step_dir, required_params, params_output)
            if nargin == 2
                name = 'MakeMean';
                description = 'make a mean  image';
                step_dir = 'Templates';
                required_params = {'image_for_mean_image'};
                params_output = {'mean_image'};
            end

            % Call RunPreproc constructor
            obj@MakePreproc(base_dir, step_no, name, description, step_dir, required_params, params_output);
        end
        
        % main function for Add mean of template to each image
        
        function params = make(obj, params)
            
            % read in image
            vol = niftiread(params.image_for_mean_image);
            
            % mean image name
            mean_image_name = fullfile(obj.step_dir, 'mean_image.nii');
            
            % write out file
            niftiwrite(mean(vol,4), mean_image_name);
            
            params.mean_image = mean_image_name;
        end
        
        
        
    end
    
end