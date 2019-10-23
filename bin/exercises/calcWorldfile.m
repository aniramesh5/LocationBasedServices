function worldfile = calcWorldfile(pathToCsv)
format long g

csv = csvread(pathToCsv);
u = csv(:,1);
v = csv(:,2);
lon = csv(:,3);
lat = csv(:,4);

A_ = [u, v, ones(length(u),1)];

bx = lon;
by = lat;

x1 = A_\bx;
x2 = A_\by;

A = x1(1);
D = x2(1);
B = x1(2);
E = x2(2);
C = x1(3);
F = x2(3);

errors = [];
for i = 1:length(lon)
	err1 = (A * u(i) + B * v(i) + C) - lon(i);
	err2 = (D * u(i) + E * v(i) + F) - lat(i);
    errors = [errors; err1, err2];
end

disp('Errors: ')
disp(errors)

worldfile = [A; D; B; E; C; F];
end