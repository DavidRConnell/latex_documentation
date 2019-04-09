function saveFigForLatex(name, projectPath)
	% Saves current figure to the figures directory of the project
	% specified by the projectPath optional.

	pathToFigures = strcat(projectPath, '/figures');
	if ~exist(projectPath, 'dir')
		error('No project at %s.', projectPath);
	elseif ~exist(pathToFigures, 'dir')
		mkdir(pathToFigures)
	end

	fullPath = strcat(pathToFigures, '/', name, '.tex');
	cleanfigure;
	matlab2tikz(fullPath, 'showInfo', false);

	isLegend = ~isempty(findall(gcf, 'type', 'Legend'));
	if ~isLegend
		clearLegend(fullPath)
	end
end

function clearLegend(path)
	fileString = fileread(path);
	clearedFileString = deleteLegendIn(fileString);
	writeString(clearedFileString, path);

	function newStr = deleteLegendIn(str);
		newStr = regexp(str, '\\addlegendentry[^\n]*\n', 'split');
		newStr = regexp(strjoin(newStr, ''), 'legend[^\n]*\n', 'split');
		newStr = strjoin(newStr, '');
	end

	function writeString(str, savePath)
		fid = fopen(savePath, 'w');
		fprintf(fid, '%s', str);
		fclose(fid);
	end
end
