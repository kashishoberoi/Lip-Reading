function training = training_o()
    %loading the positive instanceds model
    load('matlab.mat');
    positive_instances = o_positiveInstances;
    pos_dir = fullfile('D:\PROJECTS\LIP_READING\dataset\o');
    addpath(pos_dir);
    %negetive directory
    neg_dir = fullfile('D:\PROJECTS\LIP_READING\dataset\o\o_negetivefile');
    %training the model
    trainCascadeObjectDetector('o_trained_model.xml',positive_instances,neg_dir,'NumCascadeStage',5,'ObjectTrainingSize',[35,32]);
end