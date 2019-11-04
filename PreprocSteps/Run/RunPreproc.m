classdef RunPreproc
    
    
    properties
        step_no
        name
        description
        prefix
        base_dir
        required_params
        params_output
        step_dir
        is_step_run
    end
    
    
    methods
        
        % PreprocFunction Class Constructor
        function obj = RunPreproc(base_dir, step_no, name, description, prefix, required_params, params_output)
            obj.base_dir = base_dir;
            obj.step_no = step_no;
            obj.name = name;
            obj.description = description;
            obj.prefix = prefix;
            obj.required_params = required_params;
            obj.params_output = params_output;
            obj.step_dir = fullfile(obj.base_dir, 'funct', [sprintf('_%02d_', obj.step_no), obj.name]);
            obj.is_step_run = true;
        end
        
        
        % make a directory for the current step
        function make_new_dir(obj)            
            if ~exist(obj.step_dir, 'dir')
                mkdir(obj.step_dir)
            end
        end
        
        
        % make a new image_name
        function new_image_name = make_new_image_name(obj, old_image_name, step_dir)
            [~, image_name, ~] = fileparts(old_image_name);
            new_image_name = fullfile(step_dir, [obj.prefix, '_', image_name, '.nii']);
        end
        
        
        % check requirements for given functions
        function check_passed = check_required_params(obj, params)
            
            % find missing params that are required
            error_list = {};
            check_passed = true;
            for i = 1:numel(obj.required_params)
                if ~isfield(params, obj.required_params{i})
                    error_list{end+1} = obj.required_params{i};
                end
            end
            
            % if missing params display and throw an error
            if numel(error_list)
                fprintf('\nThis pipeline will fail\n');
                
                for i = 1:numel(error_list)
                    fprintf('step %02d (%s): param.%s is missing \n',obj.step_no, obj.name, error_list{i});
                end
                
                fprintf('\n');
            
                check_passed = false;
            end
            
        end
        
    end
   
    
end