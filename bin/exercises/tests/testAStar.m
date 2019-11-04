function testAStar()

%%
%testGetSuccessorIndex()

%%
%testUpdateOpenNodes()

%%
%testCalculateH()

%% 
%testInitAStar()

%%

testGetBestSuccessor()
end

function testGetBestSuccessor()
%start
node1.Lat = 42;
node1.Lon = 24;
node1.G = 0;
node1.F = 3;
node1.Pre = -1;
node1.H = [];

node2.Lat = 421;
node2.Lon = 241;
node2.G = realmax('double');
node2.F = 1;
node2.Pre = [];
node2.H = [];

node3.Lat = 445;
node3.Lon = 245;
node3.G = realmax('double');
node3.F = 1;
node3.Pre = [];
node3.H = [];

allNodes = containers.Map('KeyType', 'double', 'ValueType', 'any');
allNodes(1) = node1;
allNodes(2) = node2;
allNodes(3) = node3;

openNodes = [1, 2, 3];

getBestSuccessor(openNodes, allNodes)

end


function testInitAStar()
addpath('aStar')

load('adjacent/boston_boundingBox.mat', 'adjacent')
shapefile = shaperead('./shapefile/geocoord/boston_boundingBox.shp');

initAStar(shapefile, adjacent)

end

function testGetSuccessorIndex()
adjacent = [0 0 0 2 0 0;  % 1
            0 0 1 0 2 0;  % 2
            0 1 0 0 1 2;  % 3
            2 0 0 0 0 0;  % 4
            0 2 1 0 0 1;  % 5
            0 0 2 0 1 0]; % 6
           %1 2 3 4 5 6
            
currentNode = 2;

addpath('aStar')

getSuccessorIndex(currentNode, adjacent)

end
   
function testUpdateOpenNodes()
addpath('aStar')



currentNode = 1;
endNode = 5;




adjacent = [0 1 1 1 0 0;  % 1
            1 0 1 0 1 0;  % 2
            1 1 0 0 0 1;  % 3
            1 0 0 0 0 1;  % 4
            0 1 0 0 0 1;  % 5
            0 0 1 1 1 0]; % 6
           %1 2 3 4 5 6
           
% start node       
node1.Lat = 42;
node1.Lon = 24;
node1.G = 0;
node1.F = realmax('double');
node1.Pre = [];
node1.H = [];

node2.Lat = 421;
node2.Lon = 241;
node2.G = realmax('double');
node2.F = realmax('double');
node2.Pre = [];
node2.H = [];

node3.Lat = 445;
node3.Lon = 245;
node3.G = realmax('double');
node3.F = realmax('double');
node3.Pre = [];
node3.H = [];

node4.Lat = 245;
node4.Lon = 345;
node4.G = realmax('double');
node4.F = realmax('double');
node4.Pre = [];
node4.H = [];

% endNode
node5.Lat = 145;
node5.Lon = 145;
node5.G = realmax('double');
node5.F = realmax('double');
node5.Pre = [];
node5.H = [];

node6.Lat = 345;
node6.Lon = 445;
node6.G = realmax('double');
node6.F = realmax('double');
node6.Pre = [];
node6.H = [];


closedNodes = [5];

openNodes = [1, 2];

allNodes = containers.Map('KeyType', 'double', 'ValueType', 'any');
allNodes(1) = node1;
allNodes(2) = node2;
allNodes(3) = node3;
allNodes(4) = node4;
allNodes(5) = node5;
allNodes(6) = node6;

updateOpenNodes(currentNode, endNode, openNodes, closedNodes, allNodes, adjacent)

end

function testCalculateH()
addpath('aStar')

node.Lat = 1;
node.Lon = 1;

endNode.Lat = 2;
endNode.Lon = 1;

disp('should be 1')
H = calculateH(node,endNode)

node.Lat = 2;
node.Lon = 1;

endNode.Lat = 1;
endNode.Lon = 1;

disp('should be 1')
H = calculateH(node,endNode)

node.Lat = 1;
node.Lon = 1;

endNode.Lat = 0;
endNode.Lon = 0;

disp('should be 1')
H = calculateH(node,endNode)

end