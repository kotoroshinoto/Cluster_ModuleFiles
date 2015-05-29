set biotoolsprefix /UCHC/HPC/Gooch/biotoolmodules

proc hasBin  { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	prepend-path PATH "$path/bin"
}

proc hasInclude { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}

	prepend-path CPLUS_INCLUDE_PATH "$path/include"
        prepend-path C_INCLUDE_PATH "$path/include"
        #prepend-path -d " " CMAKE_INCLUDE_PATH "$path/include"

}

proc hasLib { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}

	prepend-path LD_LIBRARY_PATH "$path/lib"
        prepend-path LIBRARY_PATH "$path/lib"
        prepend-path LD_RUN_PATH "$path/lib"
        #prepend-path -d " " CMAKE_LIBRARY_PATH "$path/lib"
}

proc hasLib64 { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}

	prepend-path LD_LIBRARY_PATH "$path/lib64"
	prepend-path LIBRARY_PATH "$path/lib64"
	prepend-path LD_RUN_PATH "$path/lib64"
	#prepend-path -d " " CMAKE_LIBRARY_PATH "$path/lib64"

}

proc hasSHbin  { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}

	prepend-path PATH "$path/shbin"
}

proc hasCGIbin  { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}

	prepend-path PATH "$path/cgi-bin"
}

proc hasPYbin  { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}

	prepend-path PATH "$path/pybin"
}

proc hasMAN { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	set manpath_success 0
	if {[file exists "$path/man"]} {
		prepend-path MANPATH "$path/man"
		set manpath_success 1
	}	
	if {[file exists "$path/share/man"]} {
		prepend-path MANPATH "$path/share/man"
		set manpath_success 1
       	}
	#if {[file exists "$path/man"]} {
	#	
       	#}
	#TODO fill this out so it knows how to find and add man pages to relevant paths
	if {$manpath_success == 0} {puts stderr "failed to find man directory in $path  (share/man or just man)"}

	return

}

proc hasINFO { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	set infopath_success 0
	if {[file exists "$path/share/info"]} {
                prepend-path INFOPATH "$path/share/info"
		set infopath_success 1
        }
        #TODO fill this	out so it knows	how to find and	add info pages to relevant paths
	if {$infopath_success == 0} {puts stderr "failed to find $path/share/info"}

	return
}

proc setStandardPaths {name version prefix hasbin hasinclude haslib {hasman 0} {hasinfo 0} {haslib64 0} } {
	if {$hasbin != 0 } {
		hasBin $name $version $prefix
        }
	if {$hasinclude != 0} {
		hasInclude $name $version $prefix
        }
	if {$haslib != 0} {
		hasLib $name $version $prefix
	}
	if {$haslib64 != 0} {
		hasLib64 $name $version $prefix
	}
	if {$hasman != 0} {
		hasMAN $name $version $prefix
	}
	if {$hasinfo != 0} {
		hasINFO $name $version $prefix
	}
}

proc dependsOn {modulename} {
	if { ! (is-loaded $modulename) } {
		module load $modulename
	}
	prereq $modulename
}
