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
	hasLegend = ~isempty(findall(gcf, 'type', 'Legend'));
	cleanfigure;
	matlab2tikz(fullPath, 'showInfo', false);
	processoutput(fullPath);

	function processoutput(fullPath)
		fileString = fileread(fullPath);
		str = unsetSize(fileString);
		if ~hasLegend
			str = clearLegend(str);
		end
		writeString(str, fullPath);
	end
end

function newStr = unsetSize(str)
	newStr = regexp(str, '(width|height|at)[^\n]*\n', 'split');
	newStr = strjoin(newStr, '');
end

function newStr = clearLegend(str)
	newStr = regexp(str, '\\addlegendentry[^\n]*\n', 'split');
	newStr = regexp(strjoin(newStr, ''), 'legend[^\n]*\n', 'split');
	newStr = strjoin(newStr, '');
end

function writeString(str, savePath)
	fid = fopen(savePath, 'w');
	fprintf(fid, '%s', str);
	fclose(fid);
end
