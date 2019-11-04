function output = run_pipeline(pipeline, input, params)

% check pipeline has needed params first
if check_pipeline(pipeline, params)
    
    
    for step_no = 1:numel(pipeline)
        
        curr_step = pipeline{step_no}(params.base_dir, step_no);
        
        % run steps - manipulate each image in list
        % (e.g. slice-timing, realignment, co-registration)
        if curr_step.is_step_run
            
            % build outputs
            curr_step.make_new_dir();
            output.dir = curr_step.step_dir;
            output.image_name = cell(size(input.image_name));
            
            curr_step.check_required_params(params);
            
            % run step on each image
            for image_no = 1:numel(input.image_name)
                curr_image = fullfile(input.dir, input.image_name{image_no});
                output.image_name{image_no} = curr_step.run(curr_image, params);
            end
            
            input = output;
            % make step - creates input needed for a further step
            % (e.g. mask, mean image)
        else
            curr_step.check_required_params(params);
            curr_step.make_new_dir();
            
            params = curr_step.make(params);
            output = input;
        end
        
    end
    
    
else
    error('pipeline is missing params; please fill them and re-run')
end