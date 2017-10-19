source ~/.peda/peda.py
source ~/.pwngdb/pwngdb.py
source ~/.pwngdb/angelheap/gdbinit.py
source ~/.symgdb/symgdb.py

define hook-run
python
import angelheap
angelheap.init_angelheap()
end
end
