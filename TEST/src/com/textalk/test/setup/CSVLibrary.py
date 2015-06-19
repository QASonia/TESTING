import csv
import sys
import codecs
import io
from robot.api import logger
from docutils.parsers.rst.directives import encoding
reload(sys)
sys.setdefaultencoding("utf-8")


class CSVLibrary(object):

    def read_csv_file(self, filename):
        '''Read CSV file and return its content as a Python list.
        Use Robot Framework's Collections library to futher manipulate lists.
        '''

        f = open(filename, 'r')
        csvfile = csv.reader(f)
        f.close
        return [row for row in csvfile]

    def empty_csv_file(self, filename):
        '''This keyword will empty (truncate) the CSV file.
        '''

        f = open(filename, "w")
        f.truncate()
        f.close()

    def append_to_csv_file(self, filename, data):
        '''This keyword will append data to a new or existing CSV file.
        Data should be iterable (e.g. list or tuple)
        '''

        f = open(filename, 'a')
        csvfile = csv.writer(f)
        for item in data:
            csvfile.writerow([item])
        f.close()
    
    def load_test_data_from_csv_file(self, filename, tagNo, *column):
        '''Read CSV file and return its content as a Python list.
       Use Robot Framework's Collections library to futher manipulate lists.
       '''
        tagNumber = tagNo
        with open(filename, 'r') as csvlist:
            abc=csvlist.read()       
            #abc=unicode(abc)
            print repr(abc)
            dialect = csv.Sniffer().sniff(abc)
            csvlist.seek(0)
            reader = csv.reader(csvlist, dialect)
            
            header = next(reader)
            indexes = []
            value = []
            for var in column:
                indexes.append(header.index(var))
            while True:
                first_row = next(reader)
                if (first_row[1] == tagNumber):
                    Mylist = first_row
                    for index in indexes:
                        value.append(first_row[index])
                    break
        return value      
        