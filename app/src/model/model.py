#!/usr/bin/env python
# @author Jakub Mazurkiewicz

class Model:
    def __init__(self):
        self.views = []
        self.connection = None


    def set_connection(self, connection):
        if connection is None:
            raise Exception('Connection cannot be None')
        else:
            self.connection = connection


    def get_connection(self):
        return self.connection


    def execute_sql(self, sql):
        if self.connection is None:
            raise Exception('No connection has been established!')
        else:
            cursor = self.connection.cursor()
            cursor.execute(sql)
            return cursor

        

    def add_view(self, view):
        self.views.add(view)


    def remove_view(self, view):
        self.views.add(view)


    def update_views(self):
        for view in self.views:
            view.update()