classdef AppWindow < handle
    %APPWINDOW Summary of this class goes here
    %   Detailed explanation goes here
    
    properties

        parent_
        world
        ui_position_
        main_axes
        simulator
        min_x
        max_x
        
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
            
            obj.main_axes.XLim = [obj.min_x,obj.max_x];
            obj.main_axes.YLim = [-5,5];
            hold on;
            
            obj.world = World(obj.main_axes);
            obj.world.add_robot();
            
            obj.simulator = Sim(obj,obj.world,0.01);

            set(obj.parent_, 'CloseRequestFcn', @obj.ui_close);
        end
%        

        function ui_close(obj, src, event)

            fprintf('window shut\n');
            %             if(obj.is_ready_)
%                 obj.simulator_.shutdown();
            stop(obj.simulator.clock);
            delete(obj.simulator.clock);
            delete(obj.parent_);
        end

    end
end

