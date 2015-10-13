classdef AppWindow < handle
    %APPWINDOW Summary of this class goes here
    %   Detailed explanation goes here
    
    properties

        parent_
        ui_position_
        main_axes
        min_x
        max_x
        min_y
        max_y
        
    end
    
    methods
    
        function obj = AppWindow(obj)
            fprintf('create AppWindow\n');
            
            obj.ui_position_ = [100 300 500 400];
            obj.parent_ = figure('NumberTitle', 'off','Name', 'MB_sim', 'Position', obj.ui_position_);
            
            obj.main_axes = axes('Parent', obj.parent_, ...
                        'ActivePositionProperty','Position', ...
                        'Box', 'on');
            obj.main_axes.Color = [1, 0.8, 0.8];  
            grid(obj.main_axes, 'on');
            
            obj.min_x = -5;
            obj.max_x = 5;
            obj.min_y = -5;
            obj.max_y = 5;
            
            obj.main_axes.XLim = [obj.min_x,obj.max_x];
            obj.main_axes.YLim = [obj.min_y,obj.max_y];
            hold on;
            

        end


    end
end

