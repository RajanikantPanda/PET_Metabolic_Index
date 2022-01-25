clc
clear

cd('/media/panda/RAJA_RP/CSG/Aurore/PET_Results/Manoon/Norm_full')
control_subjects = dir('control/*.nii');
mcs_subjects = dir('mcs/*.nii');
mcsstar_subjects = dir('NoLOCA_sws/*.nii');
vs_subjects = dir('LOCA_sws/*.nii');
%
for i = 1:length(control_subjects)
    c_subj{i} = strrep(control_subjects(i).name, '.nii', '');
end
control_subjects = c_subj;

for i = 1:length(mcs_subjects)
    m_subj{i} = strrep(mcs_subjects(i).name, '.nii', '');
end
mcs_subjects = m_subj;

for i = 1:length(mcsstar_subjects)
    ms_subj{i} = strrep(mcsstar_subjects(i).name, '.nii', '');
end
mcsstar_subjects = ms_subj;
 
for i = 1:length(vs_subjects)
    v_subj{i} = strrep(vs_subjects(i).name, '.nii', '');
end
vs_subjects = v_subj;

clear c_subj m_subj v_subj ms_subj;


%% Register control images, and transform atlases to patient-specific space
fprintf('Registering control subjects');
for i = 1:length(control_subjects)
    fprintf('.');
    control_input_files{i} = ['control/' control_subjects{i} '.nii'];
    control_atlas_files{i} = ['control/' control_subjects{i} '_atlas.nii.gz'];
    control_normalized_files{i} = ['control/' control_subjects{i} '_normalized.nii.gz'];
    control_normalized_MNI_files{i} = ['control/' control_subjects{i} '_MNI_normalized.nii.gz'];
    
%    Register PET to template
%     [~, control_affines{i}, control_warps{i}, control_inverse_warps{i}] = ants(control_input_files{i}, 'control_template.nii.gz', 'preset', 'DOC-PET');
%     
% %    Warp atlas to PET
%     ants_warp('atlas.nii.gz', control_input_files{i}, 'o', control_atlas_files{i}, 'n', 'NearestNeighbor', '-i', control_affines{i}, control_inverse_warps{i});
end
fprintf(' Done.\n');

%% Create reference distribution
% fprintf('Creating reference distribution... ');
% [dist, range] = create_mean_distribution(control_input_files, control_atlas_files);
% fprintf(' Done.\n');
% %% Normalize control images, save normalized and MNI-space registered normalized images. 
% fprintf('Normalizing control subjects');
% for i = 1:length(control_subjects)
%     fprintf('.');
%     
%     % Normalize PET
%     normalize_to_dist(control_input_files{i}, control_atlas_files{i}, range, dist, 'out_file', control_normalized_files{i});
%     
%     % Warp normalized PET to MNI-space
%     ants_warp(control_normalized_files{i}, 'patient_template.nii.gz', 'o', control_normalized_MNI_files{i}, 'n', 'BSpline', control_warps{i}, control_affines{i});
% end
% fprintf(' Done.\n');

%% Register and normalize mcs images, save normalized and MNI-space registered normalized images. 
fprintf('Registering and normalizing MCS subjects');
for i = 1:length(mcs_subjects)
    fprintf('.');
    mcs_input_files{i} = ['mcs/' mcs_subjects{i} '.nii'];
    mcs_atlas_files{i} = ['mcs/' mcs_subjects{i} '_atlas.nii.gz'];
    mcs_normalized_files{i} = ['mcs/' mcs_subjects{i} '_normalized.nii.gz'];
    mcs_normalized_MNI_files{i} = ['mcs/' mcs_subjects{i} '_MNI_normalized.nii.gz'];
    
%     % Register PET to template
%     [~, mcs_affines{i}, mcs_warps{i}, mcs_inverse_warps{i}] = ants(mcs_input_files{i}, 'patient_template.nii.gz', 'preset', 'DOC-PET');
%     
%     % Warp atlas to PET
%     ants_warp('atlas.nii.gz', mcs_input_files{i}, 'o', mcs_atlas_files{i}, 'n', 'NearestNeighbor', '-i', mcs_affines{i}, mcs_inverse_warps{i});
%     
%     % Normalize PET 
%     normalize_to_dist(mcs_input_files{i}, mcs_atlas_files{i}, range, dist, 'out_file', mcs_normalized_files{i});
%     
%     % Warp normalized PET to MNI-space
%     ants_warp(mcs_normalized_files{i}, 'patient_template.nii.gz', 'o', mcs_normalized_MNI_files{i}, 'n', 'BSpline', mcs_warps{i}, mcs_affines{i});
end
fprintf(' Done.\n');

%% Register and normalize vs images, save normalized and MNI-space registered normalized images. 
fprintf('Registering and normalizing LOCA_sws subjects');
for i = 1:length(vs_subjects)
    fprintf('.');
    vs_input_files{i} = ['LOCA_sws/' vs_subjects{i} '.nii'];
    vs_atlas_files{i} = ['LOCA_sws/' vs_subjects{i} '_atlas.nii.gz'];
    vs_normalized_files{i} = ['LOCA_sws/' vs_subjects{i} '_normalized.nii.gz'];
    vs_normalized_MNI_files{i} = ['LOCA_sws/' vs_subjects{i} '_MNI_normalized.nii.gz'];
    
%     % Register PET to template
%     [~, vs_affines{i}, vs_warps{i}, vs_inverse_warps{i}] = ants(vs_input_files{i}, 'patient_template.nii.gz', 'preset', 'DOC-PET');
%     
%     % Warp atlas to PET
%     ants_warp('atlas.nii.gz', vs_input_files{i}, 'o', vs_atlas_files{i}, 'n', 'NearestNeighbor', '-i', vs_affines{i}, vs_inverse_warps{i});
%     
%     % Normalize PET 
%     normalize_to_dist(vs_input_files{i}, vs_atlas_files{i}, range, dist, 'out_file', vs_normalized_files{i});
%     
%     % Warp normalized PET to MNI-space
%     ants_warp(vs_normalized_files{i}, 'patient_template.nii.gz', 'o', vs_normalized_MNI_files{i}, 'n', 'BSpline', vs_warps{i}, vs_affines{i});
end
fprintf(' Done.\n');

%% Register and normalize NoLOCA_sws images, save normalized and MNI-space registered normalized images. 
fprintf('Registering and normalizing NoLOCA_sws subjects');
for i = 1:length(mcsstar_subjects)
    fprintf('.');
    mcsstar_input_files{i} = ['NoLOCA_sws/' mcsstar_subjects{i} '.nii'];
    mcsstar_atlas_files{i} = ['NoLOCA_sws/' mcsstar_subjects{i} '_atlas.nii.gz'];
    mcsstar_normalized_files{i} = ['NoLOCA_sws/' mcsstar_subjects{i} '_normalized.nii.gz'];
    mcsstar_normalized_MNI_files{i} = ['NoLOCA_sws/' mcsstar_subjects{i} '_MNI_normalized.nii.gz'];
    
%     % Register PET to template
%     [~, mcsstar_affines{i}, mcsstar_warps{i}, mcsstar_inverse_warps{i}] = ants(mcsstar_input_files{i}, 'patient_template.nii.gz', 'preset', 'DOC-PET');
%     
%     % Warp atlas to PET
%     ants_warp('atlas.nii.gz', mcsstar_input_files{i}, 'o', mcsstar_atlas_files{i}, 'n', 'NearestNeighbor', '-i', mcsstar_affines{i}, mcsstar_inverse_warps{i});
%     
%     % Normalize PET 
%     normalize_to_dist(mcsstar_input_files{i}, mcsstar_atlas_files{i}, range, dist, 'out_file', mcsstar_normalized_files{i});
%     
%     % Warp normalized PET to MNI-space
%     ants_warp(mcsstar_normalized_files{i}, 'patient_template.nii.gz', 'o', mcsstar_normalized_MNI_files{i}, 'n', 'BSpline', mcsstar_warps{i}, mcsstar_affines{i});
end
fprintf(' Done.\n');

%% Get high hemisphere means
for i = 1:length(control_subjects)
    pet = load_nii(control_normalized_files{i});      %pet = reslice_nii(control_normalized_files{i}); 
    atlas = load_nii(control_atlas_files{i});         %atlas = reslice_nii(control_atlas_files{i}); 
    
    l_norm_mean(i) = mean(pet.img(0 < atlas.img & atlas.img < 49));
    r_norm_mean(i) = mean(pet.img(48 < atlas.img & atlas.img < 100));
    
    control_high_hemisphere(i) = max([l_norm_mean(i), r_norm_mean(i)]);
    control_low_hemisphere(i) = min([l_norm_mean(i), r_norm_mean(i)]);
end

for i = 1:length(mcs_subjects)
    pet = load_nii(mcs_normalized_files{i});      %    pet = reslice_nii(mcs_normalized_files{i});   % 
    atlas = load_nii(mcs_atlas_files{i});         %    atlas = reslice_nii(mcs_atlas_files{i});      % 
    l_norm_mean(i) = mean(pet.img(0 < atlas.img & atlas.img < 49));
    r_norm_mean(i) = mean(pet.img(48 < atlas.img & atlas.img < 100));
    
    mcs_high_hemisphere(i) = max([l_norm_mean(i), r_norm_mean(i)]);
    mcs_low_hemisphere(i) = min([l_norm_mean(i), r_norm_mean(i)]);
end

for i = 1:length(mcsstar_subjects)
    pet = load_nii(mcsstar_normalized_files{i});      %    pet = reslice_nii(mcsstar_normalized_files{i});   %
    atlas = load_nii(mcsstar_atlas_files{i});         %    atlas = reslice_nii(mcsstar_atlas_files{i});      %
    l_norm_mean(i) = mean(pet.img(0 < atlas.img & atlas.img < 49));
    r_norm_mean(i) = mean(pet.img(48 < atlas.img & atlas.img < 100));
    
    mcsstar_high_hemisphere(i) = max([l_norm_mean(i), r_norm_mean(i)]);
    mcsstar_low_hemisphere(i) = min([l_norm_mean(i), r_norm_mean(i)]);
end
%
for i = 1:length(vs_subjects)
    pet = load_nii(vs_normalized_files{i});     %    pet = reslice_nii(vs_normalized_files{i});    %
    atlas = load_nii(vs_atlas_files{i});        %    atlas = reslice_nii(vs_atlas_files{i});       %
    
    l_norm_mean(i) = mean(pet.img(0 < atlas.img & atlas.img < 49));
    r_norm_mean(i) = mean(pet.img(48 < atlas.img & atlas.img < 100));
    
    vs_high_hemisphere(i) = max([l_norm_mean(i), r_norm_mean(i)]);
    vs_low_hemisphere(i) = min([l_norm_mean(i), r_norm_mean(i)]);
end
fprintf('Hemispheric metabolisim value computation..... Done.\n');
%% Plot results
f = figure;
bar([mean(control_high_hemisphere), mean(mcs_high_hemisphere), mean(mcsstar_high_hemisphere), mean(vs_high_hemisphere)]);
hold on;
errorbar([mean(control_high_hemisphere), mean(mcs_high_hemisphere),  mean(mcsstar_high_hemisphere), mean(vs_high_hemisphere)], [std(control_high_hemisphere), std(mcs_high_hemisphere), std(mcsstar_high_hemisphere), std(vs_high_hemisphere)], '.')
set(gca, 'XTickLabel', {'Control', 'MCS',  'MCS*', 'VS'});
[h,p_cm]=ttest2(control_high_hemisphere,mcs_high_hemisphere)
[h,p_cms]=ttest2(control_high_hemisphere,mcsstar_high_hemisphere)
[h,p_cv]=ttest2(control_high_hemisphere,vs_high_hemisphere)
[h,p_mms]=ttest2(mcs_high_hemisphere,mcsstar_high_hemisphere)
[h,p_mv]=ttest2(mcs_high_hemisphere,vs_high_hemisphere)
[h,p_mstarv]=ttest2(mcsstar_high_hemisphere,vs_high_hemisphere)

%% Plot results with doted bar
Grp=[1*ones(size(mcsstar_high_hemisphere,2),1);2*ones(size(vs_high_hemisphere,2),1);3*ones(size(mcs_high_hemisphere,2),1);4*ones(size(control_high_hemisphere,2),1);];
high_hemisphere=[mcsstar_high_hemisphere';vs_high_hemisphere';mcs_high_hemisphere';control_high_hemisphere'];
figure(); notBoxPlot(high_hemisphere,Grp,0.5,'patch',ones(length(high_hemisphere),1));
set(gca, 'XTickLabel', {'No-Loca', 'LOCA',  'MCS-', 'Control'}); ylabel('MIBH')
%low_hemisphere=[control_low_hemisphere';mcs_low_hemisphere';mcsstar_low_hemisphere';vs_low_hemisphere'];
%figure(); notBoxPlot(low_hemisphere,Grp,0.5,'patch',ones(length(low_hemisphere),1));
%set(gca, 'XTickLabel', {'Controls', 'MCS',  'MCS*', 'UWS'}); ylabel('Low Hemisphere')