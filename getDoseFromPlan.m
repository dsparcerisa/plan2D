function dose = getDoseFromPlan(doseCanvas, plan, dz, targetTh, targetSPR, N0)
% CartesianGrid2D N0 = getNfromPlan(struct plan, CG2D profile0)
% Returns fluence map at Z=0 from struct plan and profile from single beam

pC2pNumber = 1e7/1.602176634;
doseCanvas.data(:) = 0;
limits = [doseCanvas.minX doseCanvas.maxX doseCanvas.minY doseCanvas.maxY];
doseKernel = getDoseMap(plan.E, plan.Z, dz, pC2pNumber, targetTh, targetSPR, N0);

for i=1:plan.numSpots
    Di = doseKernel.copy;
    Di.data = plan.Q(i) * Di.data;
    Di.shift([plan.X(i) plan.Y(i)]);
    
    doseCanvas = doseCanvas + Di;
end
doseCanvas.crop(limits);
dose = doseCanvas;

end

