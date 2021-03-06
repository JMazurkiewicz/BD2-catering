#!/usr/bin/env python
# @author Jakub Mazurkiewicz

from view.addclientview import NewClientView
from view.newemployeeview import NewEmployeeView
from view.menuview import MenuView
from view.magazineview import MagazineView
from view.employeesscheduleview import EmployeesScheduleView
from view.orderscheduleview import OrderScheduleView
from view.newmealview import NewMealView
from view.neworderview import NewOrderView
from view.newproductview import NewProductView
import tkinter as tk
from view import View

class ControlPanelView(View):
    def __init__(self, parent, controller):
        View.__init__(self, parent, controller)

        self.button_frame = tk.Frame(self)
        self.button_frame.grid(row=0, column=0)

        self.buttons = []
        self.__build_buttons()
        self.grid_columnconfigure(0, weight=1)

   
    def __build_buttons(self):
        button = tk.Button(self.button_frame, text='Products')
        button.grid(row=0, column=0)
        button.configure(command=self.on_product_button)
        self.buttons.append(button)

        button = tk.Button(self.button_frame, text='Vehicles')
        button.grid(row=0, column=1)
        self.buttons.append(button)

        button = tk.Button(self.button_frame, text='Magazine')
        button.configure(command=self.on_magazine_button_click)
        button.grid(row=0, column=2)
        self.buttons.append(button)

        button = tk.Button(self.button_frame, text='Menu')
        button.grid(row=0, column=3)
        button.configure(command=self.on_menu_button_click)
        self.buttons.append(button)

        button = tk.Button(self.button_frame, text='Edit employees')
        button.grid(row=1, column=0)
        self.buttons.append(button)

        button = tk.Button(self.button_frame, text='Add employee')
        button.grid(row=1, column=1)
        button.configure(command=self.on_add_employee_button_click)
        self.buttons.append(button)

        button = tk.Button(self.button_frame, text='Order calendar')
        button.grid(row=1, column=2)
        button.configure(command=self.on_order_button)
        self.buttons.append(button)

        button = tk.Button(self.button_frame, text='Employee calendar')
        button.grid(row=1, column=3)
        button.configure(command=self.on_employee_button)
        self.buttons.append(button)

        button = tk.Button(self.button_frame, text='Add Client')
        button.grid(row=2, column=0)
        button.configure(command=self.on_client_button)
        self.buttons.append(button)


    def on_order_button(self):
       self.controller.display_view(OrderScheduleView)


    def on_vehicles_button(self):
        self.controller.display_view(NewProductView)


    def on_meal_button(self):
        self.controller.display_view(NewMealView)


    def on_employee_button(self):
        self.controller.display_view(EmployeesScheduleView)


    def on_product_button(self):
        self.controller.display_view(NewProductView)


    def on_product_button(self):
        self.controller.display_view(NewProductView)


    def on_magazine_button_click(self):
        self.controller.display_view(MagazineView)


    def on_menu_button_click(self):
        self.controller.display_view(MenuView)

    
    def on_add_employee_button_click(self):
        self.controller.display_view(NewEmployeeView)

    def on_client_button(self):
        self.controller.display_view(NewClientView)