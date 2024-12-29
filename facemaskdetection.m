clc
clear all
close all;
cam=webcam;
while true
e=cam.snapshot;
FDetect=vision.CascadeObjectDetector('Mouth','MergeThreshold',100);
I=e;
BB_Mouth=step(FDetect,I);
imshow(I);
hold on;
%%
FDetect=vision.CascadeObjectDetector('Nose','MergeThreshold',16);
I=e;
BB_Nose=step(FDetect,I);
imshow(I);
hold on;
if(sum(sum(BB_Nose))==0 && sum(sum(BB_Mouth))==0)
    FDetect=vision.CascadeObjectDetector('FrontalFaceLBP','MergeThreshold',10);
    BB_Mouth=step(FDetect,I);
    if(sum(sum(BB_Mouth))~=0)
    title('Remove Hand Please');
    defaultString = 'Remove Hand from face.';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString);
    else
        title('Mask Present');
    defaultString = 'Thank You for wearing Mask.';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString);
    end
elseif((sum(sum(BB_Nose))~=0 && sum(sum(BB_Mouth))==0)||(sum(sum(BB_Nose))==0 && sum(sum(BB_Mouth))~=0))
for i=1:size(BB_Nose,1)
rectangle('Position',BB_Nose(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
end
for i=1:size(BB_Mouth,1)
rectangle('Position',BB_Mouth(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
end
title('Please wear mask properly');
defaultString = 'Please wear mask properly.';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString);
else
    for i=1:size(BB_Nose,1)
rectangle('Position',BB_Nose(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
end
for i=1:size(BB_Mouth,1)
rectangle('Position',BB_Mouth(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
end
title('Please wear Mask');
defaultString = 'Please wear Mask.';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString);
end
pause
end
