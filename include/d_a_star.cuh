#ifdef __NVCC__

#ifndef D_A_STAR_CUH
#define D_A_STAR_CUH

#include "dynamic_graph.cuh"


template <class T, class U>
class GPU_D_A_Star
{
    private:

        int num_updates;

        GPU_Dynamic_Graph<T> *graph;
        GPU_Dynamic_Graph<T> rev_graph;
        U* Hx;
        U* Cx;

        unsigned int start_node;
        unsigned int end_node;

        unsigned int* PQ;
        unsigned int* PQ_size;
        unsigned int num_pq;
       
        int* open_list;
        int* parent;
        int* parent_old;

        bool is_set_hx;

        int flag_end;
        int flag_found;

        int* next_vertices_flag;
        int* next_vertices;
        int next_vertices_size;

        //config params
        int num_threads;

        //device pointers
        U* d_Hx;
        U* d_Cx;
        unsigned int* d_PQ;
        unsigned int* d_PQ_size;
        int* d_open_list;
        int* d_parent;
        int* d_parent_old;

        int* d_flag_end;
        int* d_flag_found;

        int* d_next_vertices_flag;
        int* d_next_vertices;
        int* d_next_vertices_size;

        int* d_expand_nodes;
        int* d_expand_nodes_size;

        int* d_lock;

        //private functions

        void __alloc_cpu();
        void __alloc_gpu();
        void __copy_to_gpu();

        void extract_min();
        void expand();
        void insert();

        void maintain_heap();
        void set_flags();

        void check_all_min_pq();

        bool is_empty_pq_cpu();

        std::vector<int> initial_path();
        std::vector<int> updated_path();

        FILE* update_file;
    
    public:
        
        GPU_D_A_Star(GPU_Dynamic_Graph<T> *graph, unsigned int start,unsigned int end, unsigned int K );

        void set_heuristics(U* hx);

        std::vector<int> get_path();            //alloc gpu here

        void set_update_file(FILE* fptr);

        void free_gpu();


};

#include "d_a_star.cu"



#endif

#endif