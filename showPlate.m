function showPlate(plate)
figure
[x,y] = meshgrid(1:12, 1:8);
scatter(x(:), y(:), 300, plate(:), 'filled')
set(gca, 'Ydir', 'reverse')
hold on
scatter(x(:), y(:), 600)
axis([0 13 0 9]);
colorbar
end

