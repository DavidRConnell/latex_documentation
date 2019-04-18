# LaTeX Documentation

The goal of this package is to remove the redundancies in producing LaTeX
documents and integrate MATLAB and python programs into LaTeX projects to
ease adding plots and tables.
LaTeX allows for a lot of flexibility setting document style and
formatting however, by default these settings must be recreated for each
document as well as elements within documents, like floats.
This package generates tex files based on an rc file, leaving you to worry
only about the documents content.
Additionally, any template sty package can be used and, with a LaTeX
background, new packages can be created from those provided.

## Installation

This package requires a unix based file hierarchy, bash, and LaTeX.
To install, cd into the parent directory yon want to use to store the
package and run:

	git clone https://github.com/DavidRConnell/latex_documentation.git
	./install.sh

This links the shell scripts and LaTeX packages to the appropriate
locations and generates a docsrc resource file in ~/.config.

To install the additional MATLAB and python files for creating tables and
figures run the following commands:

	./installmatlabfiles.sh /path/to/matlab/dir
	./installpythonfiles.sh /path/to/python/dir

Where the paths should be replaced with the desired locations which need to
be in the MATLAB/python path or added to it.
For MATLAB, if you don't know where to send link them, ~/Documents/MATLAB
will likely be a good choice.
Otherwise running the following commands in the MATLAB command line will
add a new directory to MATLAB's path:

	addpath /path/to/dir
	savepath

Python's path is saved as an environment variable named PYTHONPATH.
To check the current path open a terminal and run:

	echo $PYTHONPATH

It may not exist yet.
To add a new directory run:

	export PYTHONPATH='path/to/dir':$PYTHONPATH

This will not be saved once the session ends; add the above line to
~/.bashrc or the analogous file for the shell you use.

**Note:** The [matlab2tikz](https://www.mathworks.com/matlabcentral/fileexchange/22022-matlab2tikz-matlab2tikz) package is needed for generating tikz figures in MATLAB and the
[matplotlab2tikz](https://pypi.org/project/matplotlib2tikz/) is needed for
python in addition to the matplotlib and numpy modules.

## Set up

The docsrc file created in ~/.config sets global documentation options.
Additionally, docsrc files can be made within the parent directory of a
project to override the global file for all projects in the directory.

An example file docsrc should look like:

	AUTHOR="John Doe"
	EMAIL="john_doe@aol.com"
	DOCTYPE=rushdoc

	MAINFONT=helvetica
	TITLEFONT=helvetica

	NUMBERPAGES=false
	USETWOCOLUMN=true
	ADDABSTRACT=true

	DOEXPORTPDF=true
	DOCDIR=~/documents/documentation
	EXPORTDIR=~/Dropbox/documentation

The first five values may be left blank, resulting in empty values in the
main file (that can be manually added later).
Leaving the doctype and fonts blank will still produce a main file but latexmk
will fail unless when they are unset.

`NUMBERPAGES` to `DOEXPORTPDF` should be either true or false (bash treats an
unset vale as true).
The remaining two options can be ignored when `DOEXPORTPDF` is false.

If `ADDABSTRACT` is true `\maketitleandabstract{filename}` is used in place
off `\maketitle` where filename is the file containing the abstract located
under the sections sub directory (similar to adding sections in [adding
content](#addcontent)).

All values consisting of more than one word should be wrapped in "" (and
all values can be wrapped in "" if desired).

`DOCTYPE` should be the name of a template package.
An example template package rushdoc is found in packages (see [Creating
additional packages](#packages) for more info).
The term "template package" here simply means a sty file that sets style
and formatting.

The fonts can be any font installed on your machine. Title font controls
the font of the section headings as well as the title.

To export the pdfs to another directory (possibly a shared directory where
you don't want the source code making a mess) set `DOEXPORTPDF` to true and
add the directory name where all the projects which are to be exported will
be stored under `DOCDIR` and where the pdfs are to be copied in `EXPORTDIR`.
This can be a multilevel hierarchy. For example `DOCDIR` may contain
subdirectories for several groups of documentation. For every project
created in one of these subdirectories, whenever the pdf is created with
buildtexpdf it will be sent to `EXPORTDIR` with the same file tree.

Local docsrcs can be added to the parent directory of a project and will
override the values for all projects in that directory. Only the variables
to change need be set i.e. to change the author and email for one directory
add to it a docsrc containing:

	AUTHOR="Jane Smith"
	EMAIL="jane_smith@netscape.com"

## Use

### New projects

To create a new project, after setting up ~/.config/docsrc, run:

	mkdoc projectname title

With appropriate values for `projectname` and `title`. This makes a new
directory with the given name populated with a sections directory and
`projectname`.tex (what I refer to as the main file) generated using
`title` and the values from docsrc.

As an example the following creates an example project in the
~/documentation directory:

	cd ~/documentation
	mkdoc example "LaTeX Documentation Example"
	cd example

At this time the file tree looks like:

	example
	├── example.tex
	└── sections/

Running `buildtexpdf example` should produce example.pdf.

**Note:** Adding a docsrc to example would not make any changes. For settings
that affect all (and only) projects within ~/documentation a docsrc should
be added to ~/documentation/docsrc.

### <a name="addcontent"><\a>Adding content

Sections added to the sections directory can be input to the project with:

	...
	\begin{document}
		\pagenumbering{gobble}
		\maketitle

		\inputsection[optional name]{filename}
	\end{document}

In the main file.
If no optional name is included the section will be named as the
capitalized file name otherwise the optional name is used.
In addition to the plain `\inputsection` macro, a star version (i.e.
`\inputsection*{filename}`) exist which does not add a section header.

**Note:**: `inputsection` searches the sections directory by default so there's
no need to prepend sections to the filename nor do you need to add the tex
extension.

Similarly, there are `inputsubsection` and `inputappendix` macros.
Subsection should be kept in the sections directory and appendices a
appendices directory.
Include the appendix switch before inputing any appendices.
In the main file add:

	...
	\begin{document}
	...
		\appendix
		\inputappendix[optional name]{filename}
	\end{document}

This changes tells LaTeX to start numbering new sections as appendices.

### Generating floats

If the MATLAB and/or python files have been installed plots can be saved as
tikz figures and matrices and numpy arrays can be saved in LaTeX table
format.
These files are saved to the figures and tables subdirectories respectively
within the provided LaTeX project.

Using MATLAB a sin wave plot and random data can be saved to the example
project with:

generateFloats.m
	function generateFloats
		time = 1:0.1:10;
		wave = sin(2* pi * time * 0.25);

		plot(time, wave)
		xlabel('time')
		ylabel('sin')
		saveFigForLatex('matlabfigure', '~/documentation/example');

		d.cheader = {'names', 'w', 'x', 'y', 'z'};
		d.rheader = {'a', 'b', 'c', 'd', 'e'};
		d.data = rand(5, 4);

		saveTableForLatex(d, 'matlabtable', '../test/this/');
	end

This will also create the figures and tables subdirectories if they don't
yet exist.
Now the file tree will look like:

	example
	├── example.tex
	├── figures
	│   └── matlabfigure.tex
	├── sections/
	└── tables
		└── matlabtable.tex

If the same parent directory for documentation is going to be used often it
may be worth creating a wrapper for `saveFigForLatex.m` and
`saveTabForLatex.m` that includes the path to documentation.
For example:

saveFigForDocumentation.m
	function saveFigForDocumentation(name, project)
		% Wrapper for saveFigForLatex to simplify saving to the documentation
		% directory.
		%
		% USAGE: saveFigForDocumentation(figureName, project);

		projectPath = ['~/documentation/', project];
		saveFigForLatex(name, projectPath);
	end

An analogous program for python would be:

generate_floats.py
	import save_for_latex as sfl
	import matplotlib.pyplot as plt
	import numpy as np

	sfl.set_project_path('~/documentation/example')

	t = np.linspace(1, 10, 100)
	s = np.sin(2 * np.pi * t * 0.25)

	plt.plot(t, s)
	plt.xlabel('time')
	plt.ylabel('sin')
	sfl.fig('pythonfigure')

	data = np.random.rand(3, 4)
	rows = ['a', 'b', 'c']
	columns = ['names', 'w', 'x', 'y', 'z']
	sfl.table('pythontable', data, rows, columns)

Including floats in the LaTeX document is done with the `inputfigure`,
`inputtable`, and `inputsubfigure` macros of the form:

	\inputfigure[\label{fig:ex}Caption]{figurename}
	\inputtable[\label{tab:ex}Other caption]{tablename}

	\begin{figure}[ht]
		\centering
		\inputsubfigure[%
				\label{fig:subfiga}caption for subfig a
			]{figurewidth}{subfiga}
		\inputsubfigure*[%
				caption for subfig b
			]{figurewidth}{subfigb}
		\inputsubfigure[%
				caption for subfig c
			]{figurewidth}{subfigc}
		\caption{\label{fig:subfigures}%
				General caption.
			}
	\end{figure}

Tables are expected to be in ./tables and figures in ./figures.
File extensions are not needed.
If there are multiple figures with the same name but different extensions
the extension with the highest priority will be chosen starting with .pgf
then .tex.

The labels and captions are not required.
If labels are used `\autoref{fig:ex}` can be used to reference them in the
text adding the type based on whats before the ":" (see
[referncing](https://en.wikibooks.org/wiki/LaTeX/Labels_and_Cross-referencing)
for more info).

The star variant of `\inputsubfigure` places the next subfigure on the line
below.
In the example above the first two subfigures are on the same line and the
third is underneath them.

Adding the floats generated above is down by creating a new section:

	vi section/addingfloats.tex

Then adding the following:

section/addingfloats.tex
	Here we try adding some floats to a document.

	\inputfigure[%
		\label{fig:mat} Heres the plot produced with generateFloats.m
	]{matlabfigure}

	Now for some subfigures.
	\begin{figure}[ht]
		\centering
		\inputsubfigure[%
			\label{fig:py} Subfigures can be labeled separately
		]{0.45\textwidth}{pythonfigure}
		\inputsubfigure*[Another subfigure]{0.45\textwidth}{matlabfigure}
		\inputsubfigure[The last subfigure]{0.45\textwidth}{pythonfigure}
		\caption{\label{fig:sub}The entire subfigure cluster can also be
		referenced as a whole. And \autoref{fig:py} can be refernced in here.}
	\end{figure}

	Down here we can reference the top MATLAB figure with \autoref{fig:mat} and
	one of the python figures with \autoref{fig:py}

	Additionally a table can be printed with:

	\inputtable[The table created with generate\_floats.py]{pythontable}

Then the add the new section to the main file:

example.tex
	...
	\begin{document}
		\pagenumbering{gobble}
		\maketitle

		\inputsection[Adding Floats]{addingfloats}
	\end{document}

Now example.pdf can be generated:

	buildtexpdf example

## <a name="packages"></a>Creating Additional Packages
TODO
