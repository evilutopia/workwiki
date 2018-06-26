

修改修订文字的字体颜色
-----------------------------

http://www.wordbanter.com/showthread.php?t=138201
http://www.gmayor.com/installing_macro.htm

<pre>
Are all the changes appearing in blue colored font (i.e., both insertions 
and deletions) or are you only wanting to keep insertions with blue colored 
font. Either way, you are going to need to run a macro. If the latter, 
then perhaps something like this:

Sub ScratchMaco()
Dim oRev As Revision
For Each oRev In ActiveDocument.Revisions
  If oRev.Type = wdRevisionInsert Then
  oRev.Range.Font.Color = wdColorBlue
  End If
Next
End Sub

For help installing and using the macro see: 
http://www.gmayor.com/installing_macro.htm

</pre>
