clear

% addpaths
base_dir = '/data/local/john/mipipe_basic/';
addpath(genpath(fullfile(base_dir, 'utils')));
addpath(genpath(fullfile(base_dir, 'PreprocSteps')));

% create test dataset
run_no = 10;
image_dimension = [3, 3, 3, 10];
name_root = 'test_run';
output_dir = '/data/local/john/mipipe_basic/funct/_00_source_data/';
vols = create_test_dataset(run_no, image_dimension, name_root, output_dir);


%set parameters
params.base_dir = base_dir;
params.image_for_mean_image = '/data/local/john/mipipe_basic/funct/_00_source_data/test_run01.nii';
params.parfor = true;

% get input images
input = get_input_images(fullfile(params.base_dir, 'funct', '_00_source_data'));

% define pipeline
pipeline = {@RunAdd2, @MakeMean, @RunAddMean};

% run pipeline
output = run_pipeline(pipeline, input, params);


% grab pipeline values
pipe_vols = cell(run_no, 1);
for i = 1:numel(output.image_name)
    pipe_vols{i} = niftiread(fullfile(output.dir, output.image_name{i}));
end

% compute test values
mean_vol = mean(vols{1}, 4);
vols = cellfun(@(x) x+2, vols, 'UniformOutput', false);
vols = cellfun(@(x) x+mean_vol, vols, 'UniformOutput', false);

% compare test and pipeline
results_same = all(cellfun(@(x, y) all(eq(x(:), y(:))), pipe_vols, vols));

% print results of comparison
if results_same
    disp('pipeline correctly reproduces results for test example!');
    rmdir(fullfile(params.base_dir, 'funct'), 's');
else
    fprintf('pipeline does not reproduce results for test example!\nCheck out the problem!\n');
end
