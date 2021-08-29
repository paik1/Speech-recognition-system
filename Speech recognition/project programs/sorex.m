
x=[2 3 4 1 1 5 3 8 9 10 ];


% Needed by plotting mechanism
minX = min(x);
maxX = max(x);
len = length(x);

for j = 1:10
    idxMin = j;
    for i = j+1:length(x)       
        if(x(i) < x(idxMin))
            idxMin = i;
        end
    end
    tmp = x(idxMin);
    x(idxMin) = x(j);
    x(j) = tmp;
    
end