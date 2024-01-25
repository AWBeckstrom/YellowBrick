using Data;
using Data.Providers;
using Models;
using Models.Domain;
using Models.Domain.Blogs;
using Models.Requests.Blogs;
using Services.Interfaces;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;






namespace Services
{
    public class BlogService : IBlogService
    {
        IDataProvider _data = null;
        ILookUpService _lookupService = null;

        public BlogService(IDataProvider data, ILookUpService lookUpService)
        {
            _data = data;
            _lookupService = lookUpService;
        }

        public void Update(BlogUpdateRequest model, int currentUser)
        {
            _data.ExecuteNonQuery("[dbo].[Blogs_Update]", inputParamMapper: delegate (SqlParameterCollection col)
            {

                col.AddWithValue("@Id", model.Id);
                AddCommonParams(model, col, currentUser);
            },
            returnParameters: null);
        }

        public int Add(BlogAddRequest model, int currentUser)
        {
            int id = 0;
            _data.ExecuteNonQuery("[dbo].[Blogs_Insert]", inputParamMapper: delegate (SqlParameterCollection col)
            {
                AddCommonParams(model, col, currentUser);
                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;

                col.Add(idOut);
            },
            returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object anId = returnCollection["@Id"].Value;
                int.TryParse(anId.ToString(), out id);
            });
            return id;
        }

        public void DeleteBlog(int id, bool isDeleted)
        {
            _data.ExecuteNonQuery("[dbo].[Blogs_UpdateIsDeleted]", delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
                paramCollection.AddWithValue("@isDeleted", isDeleted);
            },
            returnParameters: null);
        }

        public Paged<Blog> SelectAllPaginated(int pageIndex, int pageSize)
        {
            Paged<Blog> pagedList = null;
            List<Blog> list = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[Blogs_SelectAll]", inputParamMapper: delegate (SqlParameterCollection parameterCollection)
            {
                parameterCollection.AddWithValue("@PageIndex", pageIndex);
                parameterCollection.AddWithValue("@PageSize", pageSize);
            },
            singleRecordMapper: delegate (IDataReader reader, short set)
            {
                Blog aBlog = MapSingleBlog(reader);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(reader.FieldCount - 1);
                }
                if (list == null)
                {
                    list = new List<Blog>();
                }
                list.Add(aBlog);
            });
            if (list != null)
            {
                pagedList = new Paged<Blog>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Paged<Blog> GetByCreatedByPaginated(int id, int pageIndex, int pageSize)
        {
            Paged<Blog> pagedList = null;
            List<Blog> list = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[Blogs_SelectByCreatedBy]", inputParamMapper: delegate (SqlParameterCollection parameterCollection)
                {
                    parameterCollection.AddWithValue("@Id", id);
                    parameterCollection.AddWithValue("@PageIndex", pageIndex);
                    parameterCollection.AddWithValue("@PageSize", pageSize);
                },
            singleRecordMapper: delegate (IDataReader reader, short set)
            {
                Blog aBlog = MapSingleBlog(reader);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(reader.FieldCount - 1);
                }
                if (list == null)
                {
                    list = new List<Blog>();
                }
                list.Add(aBlog);

            });
            if (list != null)
            {
                pagedList = new Paged<Blog>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public Blog GetById(int id)
        {
            Blog aBlog = null;

            _data.ExecuteCmd("[dbo].[Blogs_SelectById]", delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                },
            delegate (IDataReader reader, short set)
                {
                    aBlog = MapSingleBlog(reader);
                });
            return aBlog;
        }

        public Paged<Blog> GetByCategory(int id, int pageIndex, int pageSize)
        {
            Paged<Blog> pagedList = null;
            List<Blog> list = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[Blogs_SelectCategory]", inputParamMapper: delegate (SqlParameterCollection parameterCollection)
                {
                    parameterCollection.AddWithValue("@Id", id);
                    parameterCollection.AddWithValue("@PageIndex", pageIndex);
                    parameterCollection.AddWithValue("@PageSize", pageSize);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    Blog aBlog = MapSingleBlog(reader);
                    if (totalCount == 0)
                    {
                        totalCount = reader.GetSafeInt32(reader.FieldCount - 1);
                    }
                    if (list == null)
                    {
                        list = new List<Blog>();
                    }
                    list.Add(aBlog);
                });
            if (list != null)
            {
                pagedList = new Paged<Blog>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        private Blog MapSingleBlog(IDataReader reader)
        {
            Blog aBlog = new Blog();
            int startingIndex = 0;

            aBlog.Id = reader.GetSafeInt32(startingIndex++);
            aBlog.Category = _lookupService.MapSingleLookUp(reader, ref startingIndex);
            aBlog.Author = reader.DeserializeObject<BaseUser>(startingIndex++);
            aBlog.Title = reader.GetSafeString(startingIndex++);
            aBlog.Subject = reader.GetSafeString(startingIndex++);
            aBlog.Content = reader.GetSafeString(startingIndex++);
            aBlog.IsPublished = reader.GetSafeBool(startingIndex++);
            aBlog.ImageUrl = reader.GetSafeString(startingIndex++);
            aBlog.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aBlog.DateModified = reader.GetSafeDateTime(startingIndex++);
            aBlog.DatePublish = reader.GetSafeDateTime(startingIndex++);
            aBlog.IsDeleted = reader.GetSafeBool(startingIndex++);

            return aBlog;
        }

        private static void AddCommonParams(BlogAddRequest model, SqlParameterCollection col, int currentUser)
        {
            col.AddWithValue("@BlogCategoryId", model.BlogCategoryId);
            col.AddWithValue("@AuthorId", currentUser);
            col.AddWithValue("@Title", model.Title);
            col.AddWithValue("@Subject", model.Subject);
            col.AddWithValue("@Content", model.Content);
            col.AddWithValue("@ImageUrl", model.ImageUrl);
          }
    }
}
