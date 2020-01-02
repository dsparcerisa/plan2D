classdef Cartesian2DGridBlur
    properties
        minX {mustBeNumeric}
        maxX {mustBeNumeric}
        minY {mustBeNumeric}
        maxY {mustBeNumeric}
        dx {mustBeNumeric}
        dy {mustBeNumeric}
        NX {mustBeNumeric}
        NY {mustBeNumeric}
        data {mustBeNumeric}
        Z {mustBeNumeric}
        sigma {mustBeNumeric}
    end
    methods
        function obj = Cartesian2DGridBlur(varargin)
            if nargin == 11
                obj.minX= varargin{1};
                obj.maxX= varargin{2};
                obj.minY= varargin{3};
                obj.maxY= varargin{4};
                obj.dx= varargin{5};
                obj.dy=varargin{6};
                obj.NX=varargin{7};
                obj.NY=varargin{8};
                obj.data=varargin{9};
                obj.Z=varargin{10};
                obj.sigma=varargin{11};
            end
        end
        function dataZ= blur(obj)
             dataZ= imgaussfilt([obj.data],[obj.Z]);
             figure
             imagesc(dataZ);
             title('Fluence in Z');
             xlabel('X(cm)');
             ylabel('Y(cm)');
        end
    end
end