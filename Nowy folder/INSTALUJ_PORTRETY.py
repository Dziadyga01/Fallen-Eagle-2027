#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Naprawa struktury grafik The Fallen Eagle: 2027.

Python 3: python INSTALUJ_PORTRETY.py "C:\\sciezka\\do\\moda"
Podglad zmian: python INSTALUJ_PORTRETY.py --dry-run "C:\\sciezka\\do\\moda"
"""
from __future__ import annotations
import argparse, datetime, json, re, shutil
from pathlib import Path

SOURCE = Path(__file__).resolve().parent
EXTENSIONS = {'.txt','.yml','.yaml','.gfx','.gui','.asset','.mod','.json','.lua'}
SKIP = {'.git','.github','.venv','venv','node_modules','__pycache__'}
PATH_RE = re.compile(r'gfx/leaders/([A-Za-z0-9_]+)/([A-Za-z0-9_.-]+)\.(dds|png)')

def main():
    ap = argparse.ArgumentParser(description='Instaluje osobne foldery portretow i koryguje sciezki w plikach HOI4.')
    ap.add_argument('mod',nargs='?',help='Pelna sciezka do folderu moda zawierajacego common oraz gfx')
    ap.add_argument('--dry-run',action='store_true',help='Wypisuje plan bez dokonywania zmian')
    ap.add_argument('--keep-flat',action='store_true',help='Nie przenosi starych plaskich obrazow do kopii')
    args = ap.parse_args()
    path=args.mod
    if not path:
        path=input('Wskaż folder moda (z podfolderami common i gfx): ').strip().strip('"')
    root=Path(path).expanduser().resolve()
    if not (root/'common'/'characters').is_dir() or not (root/'gfx').is_dir():
        raise SystemExit('BŁĄD: podany folder nie zawiera common/characters i gfx. Nie zmieniono plikow.')
    if root==SOURCE or SOURCE in root.parents:
        raise SystemExit('BŁĄD: folder gry nie może być podkatalogiem instalatora.')
    manifest=json.loads((SOURCE/'MANIFEST_PRZENIESIEN.json').read_text(encoding='utf-8'))
    assets=sorted(p for p in (SOURCE/'gfx'/'leaders').rglob('*') if p.is_file())
    backup=root/('_BACKUP_LIDERZY_'+datetime.datetime.now().strftime('%Y%m%d_%H%M%S'))
    counts={'skopiowane':0,'stare_w_backupie':0,'pliki_tekstu':0,'zmienione_odwolania':0,'braki':0}
    print('Folder moda:',root)
    print('Nowe assety:',len(assets),'| stare odwolania:',len(manifest))
    if args.dry_run:print('TRYB TESTU — nic nie zmieniam')
    else:backup.mkdir(parents=True)
    for src in assets:
        rel=src.relative_to(SOURCE);dst=root/rel
        if not args.dry_run:
            dst.parent.mkdir(parents=True,exist_ok=True)
            if dst.exists():
                bd=backup/rel;bd.parent.mkdir(parents=True,exist_ok=True)
                shutil.copy2(dst,bd)
            shutil.copy2(src,dst)
        counts['skopiowane']+=1
    if not args.keep_flat:
        for old,new in manifest.items():
            oldpath,newpath=root/old,root/new
            if not oldpath.exists():continue
            if not (SOURCE/new).is_file():
                counts['braki']+=1
                print('UWAGA: brak nowego odpowiednika',new)
                continue
            if not args.dry_run:
                bd=backup/old;bd.parent.mkdir(parents=True,exist_ok=True)
                shutil.move(str(oldpath),str(bd))
            counts['stare_w_backupie']+=1
    for f in root.rglob('*'):
        if not f.is_file() or f.suffix.lower() not in EXTENSIONS:continue
        relative=f.relative_to(root)
        if any(p in SKIP or p.startswith('_BACKUP_LIDERZY_') for p in relative.parts):continue
        try:
            raw=f.read_bytes();text=raw.decode('utf-8-sig')
        except (UnicodeDecodeError,OSError):continue
        hits=0
        def replace(m):
            nonlocal hits
            key=m.group(0)
            if key in manifest:
                hits+=1
                return manifest[key]
            return key
        newtext=PATH_RE.sub(replace,text)
        if not hits:continue
        if not args.dry_run:
            bd=backup/relative;bd.parent.mkdir(parents=True,exist_ok=True)
            shutil.copy2(f,bd)
            bom=b'\xef\xbb\xbf' if raw.startswith(b'\xef\xbb\xbf') else b''
            f.write_bytes(bom+newtext.encode('utf-8'))
        counts['pliki_tekstu']+=1
        counts['zmienione_odwolania']+=hits
    report='NAPRAWA LIDEROW — PODSUMOWANIE\n'+'\n'.join(f'{k}: {v}' for k,v in counts.items())+'\n'
    if not args.dry_run:
        (backup/'RAPORT_INSTALACJI.txt').write_text(report,encoding='utf-8')
        print('Kopia bezpieczeństwa:',backup)
    print(report)
    print('GOTOWE' if not args.dry_run else 'Aby zainstalowac, powtorz bez --dry-run.')

if __name__=='__main__':main()
