
import re
import os
import sys

def check_markdown_links(file_path):
    broken_links = []
    base_dir = os.path.dirname(file_path)

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Regex to find Markdown links: [text](link)
    # Group 1 captures the link URL
    links = re.findall(r'\[.*?\]\((.*?)\)', content)

    for link in links:
        # Ignore external URLs
        if link.startswith('http://') or link.startswith('https://'):
            continue
        
        # Ignore anchor links within the same file
        if link.startswith('#'):
            continue

        # Handle relative paths
        # Remove query parameters or anchors for file existence check
        clean_link = link.split('#')[0].split('?')[0]
        
        # Construct absolute path
        linked_file_path = os.path.abspath(os.path.join(base_dir, clean_link))

        # Check if the file exists
        if not os.path.exists(linked_file_path):
            broken_links.append(link)
            
    return broken_links

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python check_links.py <markdown_file_path>")
        sys.exit(1)

    md_file = sys.argv[1]
    
    if not os.path.exists(md_file):
        print(f"Error: File not found - {md_file}")
        sys.exit(1)

    broken = check_markdown_links(md_file)
    if broken:
        for link in broken:
            print(f"BROKEN_LINK: {link}")
        sys.exit(1) # Indicate failure if broken links are found
    else:
        sys.exit(0) # Indicate success
