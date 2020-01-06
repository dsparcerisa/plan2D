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
            %Cartesian2DGridBlur(minX,maxX,minY,maxY,dx,dy,NX,NY,data,Z,sigma)
            if varargin{5}~=varargin{6}; %Check dx==dy
                 warning('dx and dy must be equal in order to calculte the blurred fluence in Z. Set dx==dy')
            else                 
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
        end
        function datablurredIGF= blurIGF(obj)
             %Function that calculates the blurred image in the Z plane
             %using the imgaussfilt function
             datablurredIGF= imgaussfilt([obj.data],[obj.sigma]/[obj.dx]);             
             
             figure    
             subplot(1,2,1);
             imagesc([obj.data]);
             title('Original data');
             xlabel('X(cm)');
             ylabel('Y(cm)'); 
             subplot(1,2,2);
             imagesc(datablurredIGF);
             title('Imgaussfilt');
             xlabel('X(cm)');
             ylabel('Y(cm)');  
        end
        function datablurredEXP=blurEXP(obj)
             %Function that calculates the blurred image in the Z plane
             %using the exponential
             Xvalues = [obj.dx]*(1:[obj.NX]) - [obj.dx]/2;
             Yvalues = [obj.dy]*(1:[obj.NY]) - [obj.dy]/2;
             [X,Y]=meshgrid(Xvalues,Yvalues);
             X0=[obj.NX]*[obj.dx]/2-[obj.dx]/2;
             Y0=[obj.NY]*[obj.dy]/2-[obj.dy]/2;             
             datablurredEXP=exp(-((X-X0).^2/(sqrt(2)*[obj.sigma])^2)-((Y-Y0).^2/(sqrt(2)*[obj.sigma])^2));
             figure
             subplot(1,2,1);
             imagesc([obj.data]);
             title('Original data');
             xlabel('X(cm)');
             ylabel('Y(cm)'); 
             subplot(1,2,2);
             imagesc(datablurredEXP);
             title('Exponential');
             xlabel('X(cm)');
             ylabel('Y(cm)');             
        end
        function [datablurredIGF,datablurredEXP]=blurComparation(obj)
            %Function to Compare the two methods for obtaing the blurred
            %image
            datablurredIGF= blurIGF(obj);
            datablurredEXP= blurEXP(obj);
            close all
            subplot(1,2,1);
            imagesc(datablurredIGF);
            title('imgaussfilt');
            xlabel('X(cm)');
            ylabel('Y(cm)'); 
            subplot(1,2,2);
            imagesc(datablurredEXP);
            title('Exponential');
            xlabel('X(cm)');
            ylabel('Y(cm)'); 
        end
    end
end