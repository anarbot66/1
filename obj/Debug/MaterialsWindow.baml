   M S B A M L   `   `   `  ����E  AEkzamenWPF, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null'clr-namespace:EkzamenWPF
EkzamenWPF  5   	        EkzamenWPF.MaterialsWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   *localclr-namespace:EkzamenWPF     5   	     � Title$  MaterialsWindow��5   	   $	��800��6!   $	��605��5	   	    � 
ResizeMode$ NoResize=�6    � WindowStartupLocation$ CenterScreen=�6,   .��5
      � $��10q�6   .+�5   
   �� .+�5      ��  �� Orientation$ 
Horizontal=�6   .+�5      �� $
��Left=�6   $��49��63   $	��Top=�6?   $��52��6W   $��/Мастер пол.png��6b   �� 5      $��Образ плюс��6   $��49��6-   $��22(�69   6I   5      ]� 5      $��0,10,0,0q�6   .+�5      �� $ 
Horizontal=�6   $	��Top=�66   $��0,0,0,10q�6K   .+�5      �� -   5        $'��!Добавить материал��5      
�������$��0,0,10,0q�5      ���#405C73$��9q�68   �� 5      -   5        $3��-Редактировать выбранный��5      
�������$��0,0,10,0q�5      ���#405C73$��9q�68   �� 5      -   5        $ ��Резервировать��5      
�������$��0,0,10,0q�5      ���#405C73$��9q�68   �� 5      -   5        $0��*Продукция по материалу��5      
����������#405C73$��9q�5      �� 5      -   5        $%��Расчёт продукции��5      $��10,0,0,0q�5!      ���#405C73
�������$��9q�6;   5$      &   System.Windows.Controls.DataGrid  5'      -   5          Name$ MaterialsGrid��5'         AutoGenerateColumns .     
IsReadOnly .    CanUserAddRows .     SelectionMode$ Single=�5+      $��Bottom=�5,      	   Columns	 5-      0  *System.Windows.Controls.DataGridTextColumn  5.      ,  &System.Windows.Controls.DataGridColumn
   Header$
 ID��6-      Width5  /System.Windows.Controls.DataGridLengthConverter$ 50 6X   1  +System.Windows.Controls.DataGridBoundColumn   Binding 69   �� *
MaterialId+6X     5/      $
 Тип��6-   $	 100 6S    6:   �� *Type+6S     50      $
 Наименование��6-   $ * 6\    6C   �� *Name+6\     51      $
 Цена за ед.��6-   $	 100 6s    6B   �� *Price+ �� StringFormat$ {0:N2}��6s     52      $
 Ед. изм.��6-   $ 80 6X    6?   �� *Unit+6X     53      $
 В упаковке��6-   $ 80 6]    6A   �� *	PackQty+6]     54      $
 На складе��6-   $	 100 6d    6@   �� *QuantityInStock+6d     55      $
 Мин. кол-во��6-   $	 100 6e    6B   �� *MinimumAllowed+6e   57      58      59      5:      5;      