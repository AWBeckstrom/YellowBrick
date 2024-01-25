using Models;
using Models.Domain.Blogs;
using Models.Requests.Blogs;
using System.Collections.Generic;

namespace Services.Interfaces
{
    public interface IBlogService
    {
        void Update(BlogUpdateRequest model , int currentUser);

        int Add(BlogAddRequest model , int currentUser);

        void DeleteBlog(int id , bool isDeleted);

        Paged<Blog> SelectAllPaginated(int pageIndex , int pageSize);

        Paged<Blog> GetByCreatedByPaginated(int id , int pageIndex , int pageSize);

        Blog GetById(int id);

        Paged<Blog> GetByCategory(int id , int pageIndex , int pageSize);

	}
}
