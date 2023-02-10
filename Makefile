NAME_STD		= tester_std


all:

clean:
			

fclean:		clean
			

.o : .c
	@$(CPP) $(CPPFLAGS) $? -c

re:			fclean all

save:
	git commit -am "$(MAKECMDGOALS)";
	git push https://github.com/swautelet/inception;

.PHONY:		all clean fclean re test save
