import os

def read_file(file_path):


    header = []
    data_list = []    

    with open(file_path, 'r', encoding='utf-8') as file:

        edata = enumerate(file)

        for i, ele in edata:
            print(ele, end='\n')
            if(i == 0):
                header = ele.replace('\n', '').split('\t')

            if(i > 0):
                data = ele.replace('\n', '').split('\t')
                print(data)
                data_list.append(data)

    print(header)
    print(data_list)
    return True
    


def main():
    file_path = os.path.join(os.getcwd(), 'data', 'acl_sigumgo_slv_sample.dat')
    print(read_file(file_path))

if __name__ == '__main__':
    main()


