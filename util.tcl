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
	if {$manpath_success == 0} { puts stderr "failed to find man directory in $path  (share/man or just man)" }

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


proc checkBin {name version {prefix ""}} {
	puts stderr "TEST_1"
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	puts stderr "TEST_2"
	if {[file exists "$path/bin"] && [file isdirectory "$path/bin"]} {
		puts stderr "BIN PATH FOUND"
		prepend-path PATH "$path/bin"
		puts stderr "BIN PATH ADDED TO ENV_VAR"
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "$path/bin added to environmental variable: PATH" }
		puts stderr "BIN PATH DONE"
	
	} else {
		puts stderr "BIN PATH NOT FOUND"
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "failed to find $path/bin" }
	}
	puts stderr "TEST_3"
	return
	
}

proc checkInclude {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	if {[file exists "$path"] && [file isdirectory "$path"]} {
		prepend-path CPLUS_INCLUDE_PATH "$path/include"
		prepend-path C_INCLUDE_PATH "$path/include"
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "$path/include added to environmental variables: CPLUS_INCLUDE_PATH, C_INCLUDE_PATH" }
	
	} else {
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "failed to find $path" }
	}
	return
	
}

proc checkLib {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	if {[file exists "$path"] && [file isdirectory "$path"]} {
		prepend-path LD_LIBRARY_PATH "$path/lib"
		prepend-path LIBRARY_PATH "$path/lib"
		prepend-path LD_RUN_PATH "$path/lib"
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "$path/lib added to environmental variables: LD_LIBRARY_PATH, LIBRARY_PATH, LD_RUN_PATH" }
	
	} else {
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "failed to find $path" }
	}
	return
	
}

proc checkLib64 {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	
	if {[file exists "$path"] && [file isdirectory "$path"]} {
		prepend-path LD_LIBRARY_PATH "$path/lib64"
		prepend-path LIBRARY_PATH "$path/lib64"
		prepend-path LD_RUN_PATH "$path/lib64"
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "$path/lib64 added to environmental variables: LD_LIBRARY_PATH, LIBRARY_PATH, LD_RUN_PATH" }
	} else {
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "failed to find $path" }
	}
	return
}

proc checkMAN {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}	
	if {[file exists "$path/man"] && [file isdirectory "$path/man"]} {
		prepend-path MANPATH "$path/man"
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "$path/man added to environmental variable: MANPATH" }
	} else {
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "failed to find $path/man" }
	}
	if {[file exists "$path/share/man"] && [file isdirectory "$path/share/man"]} {
		prepend-path MANPATH "$path/share/man"
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "$path/share/man added to environmental variable: MANPATH" }
	} else {
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "failed to find $path/share/man" }
	}
	return
}


proc checkINFO { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version/share/info"
	} else {
		set path "$prefix/$name/$version/share/info"
	}
	if {[file exists "$path"] && [file isdirectory "$path"]} {
		prepend-path INFOPATH "$path"
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "$path added to environmental variable: INFOPATH" }
	} else {
		if([info exists $::env(MODULES_DEBUG)]) { puts stderr "failed to find $path" }
	}
	return
}

proc checkStandardPaths {name version {prefix ""} } {
	puts stderr "Checking_STD_PATHS"
	checkBin $name $version $prefix
	puts stderr "BIN CHECKED"
	checkInclude $name $version $prefix
	puts stderr "INCLUDE CHECKED"
	checkLib $name $version $prefix
	puts stderr "LIB CHECKED"
	checkLib64 $name $version $prefix
	puts stderr "LIB64 CHECKED"
	checkMAN $name $version $prefix
	puts stderr "MAN CHECKED"
	checkINFO $name $version $prefix
	puts stderr "INFO_CHECKED"
}

proc dependsOn {modulename} {
	if { ! (is-loaded $modulename) } {
		module load $modulename
	}
	prereq $modulename
}
