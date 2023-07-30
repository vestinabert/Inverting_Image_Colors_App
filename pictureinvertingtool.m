classdef appsas < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure matlab.ui.Figure
        EksportuotigautrezultatButton matlab.ui.control.Button
        IvalytiButton matlab.ui.control.Button
        InvertuotinuotraukButton matlab.ui.control.Button
        PasirinktinuotraukButton matlab.ui.control.Button
        PaveikslospalvinvertavimorankisLabel matlab.ui.control.Label
        UIAxes2 matlab.ui.control.UIAxes
        UIAxes matlab.ui.control.UIAxes
    end

    properties (Access = private)
        imginput % Description
        imgoutput % Description
    end

    % Callbacks that handle component events

    methods (Access = private)
        % Button pushed function: PasirinktinuotraukButton
        function select(app, event)
            filter = {'*.png';'*.jpg';'*.jpeg';'*.bmp'};
            [file, path]=uigetfile(filter);

            if isequal(file,0)
                figure(app.UIFigure); %
                return;
            end

            figure(app.UIFigure); %laikyti lANga virsuje
            app.imginput= imread(fullfile(path, file));
            imshow(app.imginput,'parent',app.UIAxes);
            title (app.UIAxes, "Pradinė nuotrauka");
        end

        % Button pushed function: InvertuotinuotraukButton
        function convert(app, event)
            app.imgoutput= 255-app.imginput;
            imshow(app.imgoutput,'parent',app.UIAxes2);
            title (app.UIAxes2, "Invertuota nuotrauka");
        end

        % Button pushed function: IvalytiButton
        function reset(app, event)
            cla(app.UIAxes, 'reset')
            cla(app.UIAxes2, 'reset')
            app.imginput="";
            app.imgoutput="";
            set(app.UIAxes, 'visible', 'off');
            set(app.UIAxes2, 'visible', 'off');
        end

        % Button pushed function: EksportuotigautrezultatButton
        function export(app, event)

        filter = {'*.png';'*.jpg';'*.jpeg';'*.bmp'};
        global pathname;
        pavadinimas=fullfile(pathname,filter);
        [fileName, folder]=uiputfile(pavadinimas, "Eksportuoti nuotrauką");
        if fileName ==0
            return;
        end

        pilnaspavadinimas=fullfile(folder, fileName);
        imwrite(app.imgoutput,pilnaspavadinimas);
    end

end

% Component initialization
 methods (Access = private)
    % Create UIFigure and components
    function createComponents(app)
    
        % Create UIFigure and hide until all components are created
        app.UIFigure = uifigure('Visible', 'off');
        app.UIFigure.Position = [100 100 672 502];
        app.UIFigure.Name = 'MATLAB App';
        
        % Create UIAxes
        app.UIAxes = uiaxes(app.UIFigure);
        title(app.UIAxes, 'Input')
        app.UIAxes.XTick = [];
        app.UIAxes.YTick = [];
        app.UIAxes.Visible = 'off';
        app.UIAxes.Position = [19 152 300 185];

        % Create UIAxes2
        app.UIAxes2 = uiaxes(app.UIFigure);
        title(app.UIAxes2, 'ouput')
        app.UIAxes2.XTick = [];
        app.UIAxes2.YTick = [];
        app.UIAxes2.Visible = 'off';
        app.UIAxes2.Position = [356 152 300 185];
        
        % Create PaveikslospalvinvertavimorankisLabel
        app.PaveikslospalvinvertavimorankisLabel =uilabel(app.UIFigure);
        app.PaveikslospalvinvertavimorankisLabel.FontName ='Arial';
        app.PaveikslospalvinvertavimorankisLabel.FontSize = 20;
        app.PaveikslospalvinvertavimorankisLabel.FontWeight ='bold';
        app.PaveikslospalvinvertavimorankisLabel.Position = [188 439 361 25];
        app.PaveikslospalvinvertavimorankisLabel.Text = 'Paveikslo spalvų invertavimo įrankis';
        
        % Create PasirinktinuotraukButton
        app.PasirinktinuotraukButton = uibutton(app.UIFigure,'push');
        app.PasirinktinuotraukButton.ButtonPushedFcn =createCallbackFcn(app, @select, true);
        app.PasirinktinuotraukButton.BackgroundColor = [1 0.6941 0.3882];
        app.PasirinktinuotraukButton.FontName = 'Arial';
        app.PasirinktinuotraukButton.FontWeight = 'bold';
        app.PasirinktinuotraukButton.Position = [89 383 131 22];
        app.PasirinktinuotraukButton.Text = 'Pasirinkti nuotrauką';
        
        % Create InvertuotinuotraukButton
        app.InvertuotinuotraukButton = uibutton(app.UIFigure,'push');
        app.InvertuotinuotraukButton.ButtonPushedFcn =createCallbackFcn(app, @convert, true);
        app.InvertuotinuotraukButton.BackgroundColor = [0.8941 0.4588 0.9804];
        app.InvertuotinuotraukButton.FontName = 'Arial';
        app.InvertuotinuotraukButton.FontWeight = 'bold';
        app.InvertuotinuotraukButton.Position = [271 383 132 22];
        app.InvertuotinuotraukButton.Text = 'Invertuoti nuotrauką';
        
        % Create IvalytiButton
        app.IvalytiButton = uibutton(app.UIFigure, 'push');
        app.IvalytiButton.ButtonPushedFcn = createCallbackFcn(app, @reset, true);
        app.IvalytiButton.BackgroundColor = [0.5451 0.902 0.5059];
        app.IvalytiButton.FontName = 'Arial';
        app.IvalytiButton.FontWeight = 'bold';
        app.IvalytiButton.Position = [463 383 100 22];
        app.IvalytiButton.Text = 'Išvalyti';

        % Create EksportuotigautrezultatButton
        app.EksportuotigautrezultatButton = uibutton(app.UIFigure, 'push');
        app.EksportuotigautrezultatButton.ButtonPushedFcn = createCallbackFcn(app, @export, true);
        app.EksportuotigautrezultatButton.BackgroundColor = [0.4784 0.749 1];
        app.EksportuotigautrezultatButton.FontWeight = 'bold';
        app.EksportuotigautrezultatButton.Position = [454 73 171 22];
        app.EksportuotigautrezultatButton.Text = 'Eksportuoti gautą rezultatą';
       
        % Show the figure after all components are created
        app.UIFigure.Visible = 'on';
    end
end

% App creation and deletion 
methods (Access = public)
    
    % Construct app
    function app = appsas
    
    % Create UIFigure and components
    createComponents(app)
    
    % Register the app with App Designer
    registerApp(app, app.UIFigure)
    if nargout == 0
        clear app
    end
end

 % Code that executes before app deletion
 function delete(app)

 % Delete UIFigure when app is deleted
 delete(app.UIFigure)
 end
 end
end