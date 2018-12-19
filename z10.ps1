<#
	Параметры скрипта  dest - папка назначения, src 
	папка с файломи которая копируется в папку назначения
#>
param(
	[string]$dest = "./copy",
	[string]$src = "./"
)
<#
	получаем обьекты папки через Get-Item
	с ними будем рабоать
#>
$srcDir = (Get-Item $src)
$destDir = (Get-Item $dest)
<#
	получем все файлы из папки src
	это масив обьектов файлов
#>
$files = $srcDir.GetFiles()
<#
	перебераем все файлы используя foreach
#>
ForEach ($v in $files)
{
	<#
		создаём путь к будущему файлу сомостоятльно
		получив полное имя папки и соеденив его
		с именем файла которого мы будем копирывать
	#>	
	$copedFileName = $destDir.FullName + "/" + $v.Name;
	<#
		получаем обьект будущевого файла.
		Я не использую Get-Item потомучто он кидает 
		исключение в результате которого сбрасывается
		приложение. 
		Поэтому в ручную создаём обьект файла
	#>
	$owned = New-Object -TypeName System.IO.FileInfo -ArgumentList $copedFileName
	<#
		Проверяем существует ли фаил
	#>	
	If($owned.Exists)
	{
		<#
			Если фаил сущществует то сравниваем даты
			их создания по заданию и в случии если дата
			меньше у фала что в папке src производим 
			копирываение
		#>	
		If($owned.CreationTime -lt $v.CreationTime)
		{
			Copy-Item $v.FullName $owned.FullName
		}
	}
	Else
	{
		<#
			Если файла небыло... то и копируем его по заданию
		#>	
		Copy-Item $v.FullName $owned.FullName
	}
	
}