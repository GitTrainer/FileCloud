module FoldersHelper
	require 'fileutils.rb'
	$level=0
	$path=Rails.root.to_s
	
	def downloadSubFolder(rootFolder)
		if $level==0
			Dir.mkdir(rootFolder.name)
			$path+="/"+rootFolder.name
			addFile(rootFolder,$path)
		else
			tem=$level-rootFolder.level+1
			$path=cutPath($path,tem)
			Dir.chdir($path)
			Dir.mkdir(rootFolder.name)
			$path+="/"+rootFolder.name
			addFile(rootFolder,$path)
			$level=0
		end
		Dir.chdir($path)
		child=Folder.where(:parentId=>rootFolder.id)
		if !child.empty?
			child.each do |f|
				downloadSubFolder(f)
			end
		else
			$level=rootFolder.level.to_i
		end
	end

	def addFile(rootFolder, path)
		files = rootFolder.file_up_loads
		files.each do |file|
			FileUtils.cp(file.attach.path, path)
		end
	end	

	def cutPath(oldPath,numberOfTimes)
		count=0
		oldPath=oldPath.split(Rails.root.to_s).last
		arr=oldPath.split(//)
		i=arr.length
		while i>0 do
			i-=1
			if arr[i]=="/"
				count+=1
			end
			if count==numberOfTimes
				break
			end
		end
		newPath=oldPath[0,i].prepend(Rails.root.to_s)
		
		return newPath
	end

	$listFolder=Array.new
	def getSubFolders(folder)
		$listFolder.push(folder)
		child=Folder.where(:parentId=>folder.id)
		if !child.empty?
			child.each do |f|
				getSubFolders(f)
			end
		end
		return $listFolder
	end

	def getAllTreeFolder
		roots=Folder.where(:parentId=>nil)
		hashAllFolder={}
		for i in 0..roots.length-1
   			hashAllFolder[i]=getSubTreeFolder(roots[i])
		end
		return hashAllFolder
	end

end