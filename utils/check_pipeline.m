function all_checks = check_pipeline(pipeline, params)

all_checks = [];

for step_no = 1:numel(pipeline)
    
    curr_step = pipeline{step_no}(params.base_dir, step_no);
    
    % check if params for a run step are present
    if curr_step.is_step_run
        all_checks = [all_checks, curr_step.check_required_params(params)];
        
    % check if params for a make step are present
    % also build new params if created during make step
    else        
        all_checks = [all_checks, curr_step.check_required_params(params)];
        for i = 1:numel(curr_step.params_output)
            params.(curr_step.params_output{i}) = '';
        end

    end
    
end

