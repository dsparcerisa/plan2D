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
        function obj = Cartesian2DGridBlur(varargin) %Cartesian2DGridBlur(minX,maxX,minY,maxY,dx,dy,NX,NY,data,Z,sigma)
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
        function datablurred1= blur1(obj)
             datablurred1= imgaussfilt([obj.data],[obj.sigma]);
             figure
             imagesc(datablurred1);
             title('Fluence in Z');
             xlabel('X(cm)');
             ylabel('Y(cm)');
        end
        function datablurred2=blur2(obj)
             Xvalues = [obj.dx]*(1:[obj.NX]) - [obj.dx]/2;
             Yvalues = [obj.dy]*(1:[obj.NY]) - [obj.dy]/2;
             [X,Y]=meshgrid(Xvalues,Yvalues);
             X0=[obj.NX]*[obj.dx]/2-[obj.dx]/2;
             Y0=[obj.NY]*[obj.dy]/2-[obj.dy]/2;             
             datablurred2=exp(-((X-X0).^2/(sqrt(2)*[obj.sigma])^2)-((Y-Y0).^2/(sqrt(2)*[obj.sigma])^2));
             figure
             imagesc(datablurred2);
             title('Fluence in Z');
             xlabel('X(cm)');
             ylabel('Y(cm)');             
        end
    end
end