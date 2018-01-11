REGISTER /home/hduser/Pig.jar;
--for the UPPER.java prgm in eclipse the jar file created is Pig.jar.We add that jar to PIG by using this REGISTER command.
DEFINE ConvertLowerToUPPER myudfs.UPPER();
--ConvertLowerToUPPER is the User Defined Function to access the jar file REGISTERED and perform the required action.
--myudfs is the packagename of PIGUDF project in eclipse and UPPER is the UPPER.java class in this project.
bag1= Load 'Myfile1' using PigStorage() as (line:chararray);

bag2 = foreach bag1 generate ConvertLowerToUPPER(line);

dump bag2;

store bag2 into '/home/hduser/Documents/PIG/PigOutputs/PigUdfExOp' using PigStorage(',');
