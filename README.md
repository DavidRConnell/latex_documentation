# LaTeX Documentation

The goal of this package is to remove redundancies in writing LaTeX
documents. Simplifying consistent formatting and styling documents between
projects, importing figures, tables, and other data from outside programs,
and auto generating main files.

## Installation

This package requires a unix based file hierarchy, bash, and LaTeX.
To install, cd into the parent directory yon want to use to store the
package and run:

	git clone https://github.com/DavidRConnell/latex_documentation.git
	./install

This links the shell scripts and LaTeX packages to the appropriate
locations and generates a docsrc config file in ~/.config.

To install the additional MATLAB and python files for creating tables and
figures run the following commands:

	./installmatlabfiles.sh /path/to/matlab/dir
	./installpythonfiles.sh /path/to/python/dir

Where the paths should be replaced with the desired locations which should
be in the matlab/python path or added to it.

Note: The matlab2tikz package is needed for creating LaTeX figures with
MATLAB

## Config

The docsrc file created in ~/.config sets global documentation options.
Additionally docsrc files can be made within the parent directory of a
project to override the global file for all projects in the directory.

An example file docsrc should look like:

	AUTHOR="John Doe"
	EMAIL="john_doe@aol.com"
	DOCTYPE=rushdoc

	MAINFONT=helvetica
	TITLEFONT=helvetica

	DOEXPORTPDF=true
	DOCDIR=~/documents/documentation
	EXPORTDIR=~/Dropbox/documentation

Any variables left blank will result in empty values in the main file (that
can be manually added later) except for `DOEXPORTPDF` and `EXPORTLOC` and
`DOCDIR` if `DOEXPORTPDF` is true.

All values consisting of more than one word should be wrapped in "". The
`DOCTYPE` should be the name of a package produced based on the provided
packages here (an example is rushdoc found in packages).

The fonts can be any font installed on your machine. Title font controls
the font of the section headings as well as the title.

To export the pdfs to another directory (possibly a shared directory where
you don't want the source code making a mess) set `DOEXPORTPDF` to true and
add the directory name where all the projects which are to be exported will
be stored under `DOCDIR` and where the pdfs are to be copied in `EXPORTDIR`.
This can be a multilevel hierarchy. For example `DOCDIR` may contain
subdirectories for several groups of documentation. For every project
created in one of these subdirectories, whenever the pdf is created with
buildtexpdf it will be sent to `EXPORTDIR` under the same subdirectories.

Local docsrcs should be added to the parent directory of a project and will
override the values for all projects in that directory. Only the variables
to change need be set i.e. to change the author and email for one directory
add to it a docsrc containing:

	AUTHOR="Jane Smith"
	EMAIL="jane_smith@netscape.com"

## Use

To create a new project, after setting up ~/.config/docsrc, run:

	mkdoc projectname title

With appropriate values for `projectname` and `title`. This makes a new
directory with the given name populated with a sections directory and
`projectname`.tex generated using `title` and the values from docsrc.

At this point running buildtexpdf `projectname` should produce a pdf.

Sections should be added to the sections directory and input to the project
via:

	...
	\begin{document}
		\inputsection[optional name]{filename}
	\end{document}

If no optional name is included the section will be named as the
capitalized file name otherwise optional name is used.

Note: `inputsection` searches the sections directory by default so there's
no need to prepend sections to the filename nor do you need to add the tex
extension.

Adding figures and tables to a section is done with:

	\inputfigure[\label{fig:ex}Caption]{figurename}
	\inputtable[\label{tab:ex}Other caption]{tablename}

Tables are expected to be in ./tables and figures in ./figures. File
extensions are not needed. If there are multiple figures with the same name
but different extensions the extension with the highest priority will be
chosen starting with .pgf then .tex.

The labels and captions are not required. If labels are used
`\autoref{fig:ex}` can be used to reference them in the text adding the
type based on whats before the ":" (see
[referncing](https://en.wikibooks.org/wiki/LaTeX/Labels_and_Cross-referencing)
for more info).

Subfigures can be created but require adding using a figure enviornment

	\begin{figure}[ht]
		\centering
		\inputsubfigureh[%
				\label{fig:subfiga}caption for subfig a
			]{0.45\textwidth}{subfiga}
		\inputsubfigureh[%
				caption for subfig b
			]{0.45\textwidth}{subfigb}
		\inputsubfigurev[%
				caption for subfig c
			]{0.45\textwidth}{subfigc}
		\caption{\label{fig:subfigures}%
				General caption.
			}
	\end{figure}

The h subfigures are added horizontally while the v varient adds the
subfigure below. Take not of where the labels are.

### Generating floats
TODO

## Creating Additional Packages
TODO
