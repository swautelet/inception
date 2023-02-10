NAME_STD		= tester_std


all: $(NAME_STD) $(NAME_FT) $(NAME_SCHOOL)

clean:
			$(RM) $(OBJS_STD) $(OBJS_FT) $(OBJS_SCHOOL)

fclean:		clean
			$(RM) $(NAME_FT)
			$(RM) $(NAME_STD)
			$(RM) $(NAME_SCHOOL)
			$(RM) $(LOG_FILE) $(TIME_LOG)

.o : .c
	@$(CPP) $(CPPFLAGS) $? -c

re:			fclean all

save:
	git commit -am "$(MAKECMDGOALS)";
	git push https://github.com/swautelet/inception;

.PHONY:		all clean fclean re test save
