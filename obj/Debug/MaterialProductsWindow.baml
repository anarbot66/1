   M S B A M L   `   `   `  ����  
EkzamenWPF'    !EkzamenWPF.MaterialProductsWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	     � Title$0  *Продукция с материалом��5   	   $	��400��6(   $	��600��65    � 
ResizeMode$ NoResize=�6A    � WindowStartupLocation$ CenterScreen=�6W   .��5      � $��10q�6   .+�5   
   ]� .+�5      �� $]��WСписок продукции, использующей данный материал��6   $��16(�5      $
��Bold"�6&   $��0,0,0,10q�5	      $	��Top=�6*   &   System.Windows.Controls.DataGrid  5
      -   5          Name$ ProductsGrid��5
         AutoGenerateColumns .     
IsReadOnly .    CanUserAddRows .     Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$1 +Наименование продукции��6)   	   Width5  /System.Windows.Controls.DataGridLengthConverter$	 * 6i   1  +System.Windows.Controls.DataGridBoundColumn
   Binding
 6I   �� *ProductName+6i     5      $@ :Требуемое количество материала��6)   $		 200 6�   
 6Q   �� *RequiredQuantity+ �� StringFormat$ N2��6�   5      5      5      5      