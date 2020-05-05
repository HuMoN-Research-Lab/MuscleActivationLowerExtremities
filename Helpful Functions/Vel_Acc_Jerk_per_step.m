function [rFoot_totalJerk,rJerk_per_frame,lFoot_totalJerk,lJerk_per_frame,totalJerk] = Vel_Acc_Jerk_per_step(allSteps,RFoot,LFoot)

%% Formatting of vel,acc,jerk
%velocity
rAnkVel2D =     RFoot.marVel';
lAnkVel2D =     LFoot.marVel';
%acceleration
rAnkAcc2D =     RFoot.marAcc';
lAnkAcc2D =     LFoot.marAcc';
%jerk
rAnkJerk2D =    RFoot.marJerk_abs';
lAnkJerk2D =    LFoot.marJerk_abs';

%% Formatting step per foot
for ii = allSteps(:,3)    
    %Find points where toe and heel hit ground start at frame 1
    allSteps_TO = allSteps(:,1) - (allSteps(1,1)-1);
    allSteps_HS = allSteps(:,2) - (allSteps(1,1)-1);
    
    %Right step id
    rStep_id(:,1) = allSteps_TO(find(ii == 1));
    rStep_id(:,2) = allSteps_HS(find(ii == 1));
    
    %Left step id
    lStep_id(:,1) = allSteps_TO(find(ii == 2));
    lStep_id(:,2) = allSteps_HS(find(ii == 2));    
end

%% Create frames of each step and calc vel, acc, and jerk
%Right foot
numSteps = length(rStep_id(:,1));
for ii = 1:numSteps
    iterStep =              rStep_id(ii,1):rStep_id(ii,2);
    rVel_per_frame =        rAnkVel2D(iterStep);
    rVel_per_step(ii) =     sum(rVel_per_frame);
    rAcc_per_frame =        rAnkAcc2D(iterStep);
    rAcc_per_step(ii) =     sum(rAcc_per_frame);
    rJerk_per_frame =       rAnkJerk2D(iterStep);
    rJerk_per_step(ii) =    sum(rJerk_per_frame);
end

rFoot_totalJerk = sum(rJerk_per_step);

%Left foot
numSteps = length(lStep_id(:,1));
for ii = 1:numSteps
    iterStep =               lStep_id(ii,1):lStep_id(ii,2);
    lVel_per_frame =         lAnkVel2D(iterStep);
    lVel_per_step(ii) =      sum(lVel_per_frame);
    lAcc_per_frame =         lAnkAcc2D(iterStep);
    lAcc_per_step(ii) =      sum(lAcc_per_frame);
    lJerk_per_frame =        lAnkJerk2D(iterStep);
    lJerk_per_step(ii) =     sum(lJerk_per_frame);
end

lFoot_totalJerk = sum(lJerk_per_step);

%Total jerk from LFoot and RFoot
totalJerk = plus(rFoot_totalJerk,lFoot_totalJerk);



end

