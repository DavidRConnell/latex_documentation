""" Provides methods for saving figures and tables into the paper's figures and
tables directory respectively. """

import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl

PATH_TO_PROJECT = '/Users/davidconnell/Google_Drive/Programs/MyModules/'


def set_project_path(path_to_project):
    global PATH_TO_PROJECT
    PATH_TO_PROJECT = path_to_project


def fig(name):
    """ Parameter name (string) should include the subfolder to save it to if one exists. """

    def _setup_mpl():
        pgf_with_rc_font = {
            "font.family": "sans-serif",
            "font.serif": [],
            "font.monospace":[],
            "font.sans-serif": [],
        }
        mpl.rcParams.update(pgf_with_rc_font)


    save_path = PATH_TO_PROJECT + '/figures/' + name + '.pgf'
    _make_dir_if_missing(save_path)

    _setup_mpl()
    plt.savefig(save_path, bbox_inches='tight')


def _make_dir_if_missing(path):
    dir_elements = path.split('/')
    dir_path = '/'.join(dir_elements[:-1])

    if not os.path.exists(dir_path):
        os.makedirs(dir_path)


def table(name, data, row_names, column_names):
    """ Parameters:
    name (string) should include the subfolder to save it to if one exists.
    data (numpy array)
    column_names (list of strings)
    row_names (list of strings) """

    def _format_row_names():
        new_row_names = ['\t' + name for name in row_names]
        return np.array([new_row_names]).T

    def _format_column_names():
        return ' & '.join(column_names) + ' \\\\'

    def _format_data():
        new_data = np.around(data, decimals=4)
        new_data = new_data.astype('str')
        new_data[:, -1] = [datum + ' \\\\' for datum in new_data[:, -1]]
        return new_data

    def _append_row_names_to_data():
        return np.append(row_names, data, axis=1)

    save_path = PATH_TO_PROJECT + '/tables/' + name
    file_name = save_path + '.tex'
    _make_dir_if_missing(save_path)

    len_data = data.shape[1]
    column_names = _format_column_names()
    row_names = _format_row_names()
    data = _format_data()
    data = _append_row_names_to_data()

    header = '\\begin{tabularx}{\\tablewidth}{%s} \n\t\\toprule\n\t%s\n\t\midrule' %(('X '*(len_data +1))[:-1], column_names)
    footer = '\t\\bottomrule\n\end{tabularx}'

    np.savetxt(
        file_name,
        data,
        fmt='%s',
        delimiter=' & ',
        header=header,
        footer=footer,
        comments=''
    )
